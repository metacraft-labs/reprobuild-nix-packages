# reprobuild-nix-packages

Nix provisioning contributions for canonical reprobuild package interfaces.

The catalog uses `provisioningFor` and pins every contribution to the public
interface fingerprint published by its owner. Standard tool interfaces come
from reprobuild; additional interfaces come from `reprobuild-packages`. A
stale catalog therefore fails explicitly when an interface changes instead of
silently provisioning an incompatible package.
