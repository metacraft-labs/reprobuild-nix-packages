import std/[os, unittest]

import repro_interface_artifacts
import repro_project_dsl

import ../repro as catalog

suite "Nix provisioning contribution catalog":
  test "publishes pinned contributions without redefining packages":
    let contributions = registeredProvisioningContributions()
    check contributions.len == 3
    check contributions[0].targetPackage == "bash"
    check contributions[0].targetInterfaceFingerprint.len == 64
    check contributions[0].contributor ==
      "github:metacraft-labs/reprobuild-nix-packages"
    check contributions[0].nixProvisioning[0].selector == "nixpkgs#bash"
    check registeredPackages().len == 1

    let artifact = artifactFromRegisteredDsl(getCurrentDir() / "repro.nim")
    check artifact.projectInterface.provisioningContributions.len == 3
    let roundTrip = decodeProjectInterfaceArtifact(
      encodeProjectInterfaceArtifact(artifact))
    check roundTrip.projectInterface.provisioningContributions.len == 3
