import repro_project_dsl

provisioningFor "bash":
  interfaceFingerprint "8ee476ea70e3fe6e6ff11cf09fbd7ab9d16290a0c69b74b80620ce952634dc99"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#bash", executablePath = "bin/bash",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

provisioningFor "busybox":
  interfaceFingerprint "5c65917bef060839c80d8e276c91287ea64721741eb329b0eae225d30b71a57a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#busybox", executablePath = "bin/busybox",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

provisioningFor "cmake":
  interfaceFingerprint "60173785f5b07d1afe3e590f16eb227c8dd3f2c17cea0b5c8ddd71866ca86265"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#cmake", executablePath = "bin/cmake",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

provisioningFor "llvm":
  interfaceFingerprint "a2bff9c457ff603d27320da38a1333de0780dda98aa8eafb4c7f6d759076ba2c"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#llvm.dev", executablePath = "bin/llvm-config",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

provisioningFor "patchelf":
  interfaceFingerprint "c07f348008540a694670347e4dc27318b953f3582c5412a896b05f4513e13e95"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#patchelf", executablePath = "bin/patchelf",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

package reprobuildNixPackages:
  devEnv:
    task "test",
      command = "nim c -r --nimcache:build/nimcache-nix-catalog tests/test_nix_catalog.nim",
      description = "Validate the Nix contribution catalog"
