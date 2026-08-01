import std/[os, sequtils, unittest]

import repro_interface_artifacts
import repro_project_dsl
import repro_dsl_stdlib/packages/bash as bashInterface
import repro_dsl_stdlib/packages/cmake as cmakeInterface
import packages/interfaces/busybox/repro as busyboxInterface
import packages/interfaces/llvm/repro as llvmInterface
import packages/interfaces/patchelf/repro as patchelfInterface

import ../repro as catalog

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
