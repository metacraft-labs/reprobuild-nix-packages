test:
  nim c -r --hints:off --warnings:off --out:build/test-nimcache-locality tests/test_nimcache_is_worktree_local.nim
  nim c -r --hints:off --warnings:off --nimcache:build/nimcache-nix-catalog --out:build/test-nix-catalog tests/test_nix_catalog.nim
