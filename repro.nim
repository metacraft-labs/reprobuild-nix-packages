import repro_project_dsl

provisioningFor "bash":
  interfaceFingerprint "1e0e3300812a44a0d91e10ddd03d68f1387a5f5aefddf4422159c7ec6efb8f07"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#bash", executablePath = "bin/bash",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

provisioningFor "busybox":
  interfaceFingerprint "ca4580bfa6935255b52c55283d9ef8969d477febf270e7e644e7d3374255c801"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#busybox", executablePath = "bin/busybox",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

provisioningFor "cmake":
  interfaceFingerprint "88c10dc3cef1e07d8b6a6e4f46f7eeaf757c2f1330c86d8c266a3cdd31c79dbf"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#cmake", executablePath = "bin/cmake",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

package reprobuildNixPackages:
  devEnv:
    task "test",
      command = "nim c -r --nimcache:build/nimcache-nix-catalog tests/test_nix_catalog.nim",
      description = "Validate the Nix contribution catalog"
