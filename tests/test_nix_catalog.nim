import std/[json, os, sequtils, strutils, unittest]

import repro_interface_artifacts
import repro_interface_artifacts/contribution_records
import repro_project_dsl
import repro_dsl_stdlib/nixpkgs_pin
import repro_dsl_stdlib/packages/bash as bashInterface
import repro_dsl_stdlib/packages/cmake as cmakeInterface
import packages/interfaces/busybox/repro as busyboxInterface
import packages/interfaces/llvm/repro as llvmInterface
import packages/interfaces/patchelf/repro as patchelfInterface

import ../repro as catalog

const
  RecordsFile = "provisioning-contributions.json"
    ## The contribution records as data, for consumers that cannot run the
    ## provider: the reprobuild flake's `reprobuild.lib.nixRealizationOf`
    ## reads this file from the revision of this repository it pins.
  UpdateEnvVar = "REPRO_UPDATE_CONTRIBUTION_RECORDS"
    ## `just update-contribution-records` sets it to rewrite the file.
  CatalogSize = 228
    ## The contributions `repro.nim` declares: the five realizations the
    ## catalog started with (bash, busybox, cmake, llvm, patchelf) and the
    ## packages zah/dotfiles' Home Manager configurations install (GM8 of the
    ## Gradual-Nix-To-Reprobuild-Migration plan), plus the reusable pwsh
    ## realization, one per canonical package.

suite "Nix provisioning contribution catalog":
  test "pwsh consumers receive the canonical PowerShell realization":
    # Exercise the registered catalog and the public-interface projection a
    # consumer actually receives. A tool identity reference alone cannot make
    # an undeclared or unrealized executable available on an action's PATH.
    let contributions = registeredProvisioningContributions()
    let powershell = contributions.filterIt(it.targetPackage == "pwsh")
    require powershell.len == 1
    let packages = registeredPackages()
    let interfaces = packages.filterIt(it.packageName == "pwsh")
    require interfaces.len == 1
    check interfaces[0].executables.len == 1
    check interfaces[0].executables[0].binaryName == "pwsh"
    check powershell[0].targetInterfaceFingerprint ==
      canonicalPackageInterfaceFingerprint(interfaces[0], packages)
    check not powershell[0].developInterface

    let consumer = PackageDef(packageName: "powershellConsumer", toolUses: @[
      PackageUseDef(rawConstraint: "pwsh", packageSelector: "pwsh",
        executableName: "pwsh")])
    let projected = toProjectInterface(consumer, packages, contributions)
    require projected.toolUses.len == 1
    check projected.toolUses[0].packageSelector == "pwsh"
    check projected.toolUses[0].executableName == "pwsh"
    let realizations = projected.toolUses[0].nixProvisioning
    require realizations.len == 1
    check realizations[0].selector == "nixpkgs#powershell"
    check realizations[0].executablePath == "bin/pwsh"
    check realizations[0].nixpkgsRev == CanonicalNixpkgsRev
    check realizations[0].nixpkgsNarHash == CanonicalNixpkgsNarHash

  test "publishes pinned contributions without redefining packages":
    let contributions = registeredProvisioningContributions()
    check contributions.len == CatalogSize
    let bash = contributions.filterIt(it.targetPackage == "bash")
    require bash.len == 1
    check bash[0].targetInterfaceFingerprint.len == 64
    check bash[0].contributor ==
      "github:metacraft-labs/reprobuild-nix-packages"
    check bash[0].nixProvisioning[0].selector == "nixpkgs#bash"
    # One contribution per canonical package, each with exactly one Nix
    # realization naming a nixpkgs attribute: the helper library refuses a
    # name with two (ambiguous) and a selector that names no attribute.
    var targets: seq[string]
    for contribution in contributions:
      check contribution.contributor ==
        "github:metacraft-labs/reprobuild-nix-packages"
      check contribution.nixProvisioning.len == 1
      check contribution.nixProvisioning[0].selector.startsWith("nixpkgs#")
      targets.add contribution.targetPackage
    check targets.deduplicate().len == targets.len
    let packages = registeredPackages()
    # Every contribution's target, plus this catalog's own package.
    check packages.len == CatalogSize + 1
    for contribution in contributions:
      let targets = packages.filterIt(
        it.packageName == contribution.targetPackage)
      check targets.len == 1
      check canonicalPackageInterfaceFingerprint(targets[0], packages) ==
        contribution.targetInterfaceFingerprint

    let artifact = artifactFromRegisteredDsl(getCurrentDir() / "repro.nim")
    check artifact.projectInterface.provisioningContributions.len == CatalogSize
    let roundTrip = decodeProjectInterfaceArtifact(
      encodeProjectInterfaceArtifact(artifact))
    check roundTrip.projectInterface.provisioningContributions.len == CatalogSize

  test "the committed contribution records are the catalog's records":
    # The published JSON is generated from the recipe, never hand-edited:
    # a stale file would hand Nix consumers realizations this catalog no
    # longer declares. Regenerate with `just update-contribution-records`.
    let root = getCurrentDir()
    let artifact = artifactFromRegisteredDsl(root / "repro.nim")
    let fresh = renderContributionRecords(
      artifact.projectInterface.provisioningContributions, root)
    if getEnv(UpdateEnvVar) == "1":
      writeFile(root / RecordsFile, fresh)
    check fileExists(root / RecordsFile)
    check readFile(root / RecordsFile) == fresh
    let doc = parseJson(fresh)
    check doc["format"].getStr == ContributionRecordsFormat
    check doc["contributions"].len == CatalogSize
    var bash: JsonNode
    for contribution in doc["contributions"]:
      if contribution["targetPackage"].getStr == "bash":
        bash = contribution
    require not bash.isNil
    check bash["nixProvisioning"][0]["selector"].getStr == "nixpkgs#bash"
    check bash["location"]["file"].getStr == "repro.nim"
    check not fresh.contains(root)
