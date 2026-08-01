import repro_project_dsl

provisioningFor "bash":
  interfaceFingerprint "7ef765a035113059ea950797122a2a7f45661047282acb03d5202c7e0a57b2d3"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#bash", executablePath = "bin/bash",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

provisioningFor "busybox":
  interfaceFingerprint "7b568cf3df01f7342e469a3bbed3b00e814f2d066f3549a3cacc3c2502c27cf9"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#busybox", executablePath = "bin/busybox",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

provisioningFor "cmake":
  interfaceFingerprint "69d729adc652bb64b7b05da580971b9a363702629affb51548d5174c2cacd36b"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#cmake", executablePath = "bin/cmake",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

package reprobuildNixPackages:
  devEnv:
    task "test",
      command = "nim c -r --nimcache:build/nimcache-nix-catalog tests/test_nix_catalog.nim",
      description = "Validate the Nix contribution catalog"
