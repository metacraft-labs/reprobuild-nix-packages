import repro_project_dsl
# Register the owning interfaces in direct recipe extraction too. The test
# imports used to hide this requirement; the CLI otherwise saw only host stubs.
import repro_dsl_stdlib/packages/bash
import repro_dsl_stdlib/packages/cmake
import "../reprobuild-packages/packages/interfaces/busybox/repro" as busyboxInterface
import "../reprobuild-packages/packages/interfaces/llvm/repro" as llvmInterface
import "../reprobuild-packages/packages/interfaces/patchelf/repro" as patchelfInterface

provisioningFor "bash":
  interfaceFingerprint "2df0cc8d7d9f6c4c315a70285271073e6b76ef48d4658b8bc5ad3a44d5ce72ff"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#bash", executablePath = "bin/bash",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

provisioningFor "busybox":
  interfaceFingerprint "405d24965128e720003d633e1e635a2f8f4a290c8b64968511166c8ceb6c0432"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#busybox", executablePath = "bin/busybox",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

provisioningFor "cmake":
  interfaceFingerprint "46e387d9a093ed42f24c20b5c4d647ca6af7d429604aa7012befa6c83267bd35"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#cmake", executablePath = "bin/cmake",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

provisioningFor "llvm":
  interfaceFingerprint "6d5d82b5ae0c070ca59169c28d6c0f21e08c0cc4039653d272a7dc0dc5fe0cbd"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#llvm.dev", executablePath = "bin/llvm-config",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

provisioningFor "patchelf":
  interfaceFingerprint "c3c0aed07dd83687b8e859f7f203e552cfd4bd75efabc16ccf2114781636c5a8"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#patchelf", executablePath = "bin/patchelf",
    nixpkgsRev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8",
    nixpkgsNarHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8="

package reprobuildNixPackages:
  devEnv:
    task "test",
      command = "nim c -r --nimcache:build/nimcache-nix-catalog tests/test_nix_catalog.nim",
      description = "Validate the Nix contribution catalog"
