# reprobuild-nix-packages

Nix provisioning contributions for canonical reprobuild package interfaces.

The catalog uses `provisioningFor` and pins every contribution to the public
interface fingerprint published by its owner. Standard tool interfaces come
from reprobuild; additional interfaces come from `reprobuild-packages`. A
stale catalog therefore fails explicitly when an interface changes instead of
silently provisioning an incompatible package.

`provisioning-contributions.json` publishes the same contribution records as
data, for consumers that cannot run the provider: the reprobuild flake's
`reprobuild.lib.nixRealizationOf` reads it from the revision of this
repository it pins. It is generated from `repro.nim` — run
`just update-contribution-records` after changing a contribution; `just test`
fails while the committed file is stale.
