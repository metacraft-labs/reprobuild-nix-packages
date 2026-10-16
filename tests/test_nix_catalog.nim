import std/[json, os, sequtils, strutils, unittest]

import repro_interface_artifacts
import repro_interface_artifacts/contribution_records
import repro_project_dsl
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
  CatalogSize = 227
    ## The contributions `repro.nim` declares: the five realizations the
    ## catalog started with (bash, busybox, cmake, llvm, patchelf) and the
    ## packages zah/dotfiles' Home Manager configurations install (GM8 of the
    ## Gradual-Nix-To-Reprobuild-Migration plan), one per canonical package.

suite "Nix provisioning contribution catalog":
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
