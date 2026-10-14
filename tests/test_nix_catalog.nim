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

suite "Nix provisioning contribution catalog":
  test "publishes pinned contributions without redefining packages":
    let contributions = registeredProvisioningContributions()
    check contributions.len == 5
    check contributions[0].targetPackage == "bash"
    check contributions[0].targetInterfaceFingerprint.len == 64
    check contributions[0].contributor ==
      "github:metacraft-labs/reprobuild-nix-packages"
    check contributions[0].nixProvisioning[0].selector == "nixpkgs#bash"
    let packages = registeredPackages()
    check packages.len == 6
    for contribution in contributions:
      let targets = packages.filterIt(
        it.packageName == contribution.targetPackage)
      check targets.len == 1
      check canonicalPackageInterfaceFingerprint(targets[0], packages) ==
        contribution.targetInterfaceFingerprint

    let artifact = artifactFromRegisteredDsl(getCurrentDir() / "repro.nim")
    check artifact.projectInterface.provisioningContributions.len == 5
    let roundTrip = decodeProjectInterfaceArtifact(
      encodeProjectInterfaceArtifact(artifact))
    check roundTrip.projectInterface.provisioningContributions.len == 5

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
    check doc["contributions"].len == 5
    let bash = doc["contributions"][0]
    check bash["targetPackage"].getStr == "bash"
    check bash["nixProvisioning"][0]["selector"].getStr == "nixpkgs#bash"
    check bash["location"]["file"].getStr == "repro.nim"
    check not fresh.contains(root)
