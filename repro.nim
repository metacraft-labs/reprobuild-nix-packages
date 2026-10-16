## The Nix contribution catalog: which nixpkgs attribute realizes each
## canonical Reprobuild package.
##
## Every contribution is pinned to the public interface fingerprint of the
## canonical definition it targets (imported below, so interface extraction
## sees it), so a renamed or reshaped definition fails here instead of being
## mapped by guess. The canonical definitions live in reprobuild's stdlib, in
## reprobuild-packages (`packages/interfaces/<name>`) and, for the LLM coding
## agents, in reprobuild-llm-agent-packages.
##
## The records are published as data in `provisioning-contributions.json`
## (`just update-contribution-records`), which the reprobuild flake's helper
## library reads in both directions: `reprobuild.lib.nixRealizationOf`
## (canonical name -> attribute) and `lookupNixPackageName` (a Home Manager
## derivation -> its canonical package, matched on the attribute's package
## name in the configuration's own nixpkgs), which is how `repro home compare`
## identifies the packages a Home Manager configuration installs.
##
## The attributes and executable paths were checked against the pinned
## nixpkgs (`CanonicalNixpkgsRev`): each attribute evaluates there, and each
## `executablePath` exists in its output in cache.nixos.org's NAR listing, or
## -- for unfree packages the cache does not carry -- is the package's
## `meta.mainProgram` under `bin/`. A canonical package whose Home Manager
## counterpart comes from another flake (llm-agents' amp, cursor-agent, grok,
## muse-code; antigravity-nix; reprobuild and runquota) has no nixpkgs
## attribute to name and is not contributed here.

import repro_project_dsl
import repro_dsl_stdlib/nixpkgs_pin
# The owning interfaces, registered in direct recipe extraction too (the CLI
# otherwise sees only host stubs for them).
import "../reprobuild-packages/packages/interfaces/age/repro" as ageInterface
import "../reprobuild-packages/packages/interfaces/asciinema/repro" as asciinemaInterface
import repro_dsl_stdlib/packages/attic_client as atticClientInterface
import "../reprobuild-packages/packages/interfaces/awscli/repro" as awscliInterface
import repro_dsl_stdlib/packages/bash as bashInterface
import "../reprobuild-packages/packages/interfaces/bfg-repo-cleaner/repro" as bfgRepoCleanerInterface
import "../reprobuild-packages/packages/interfaces/bitwarden/repro" as bitwardenInterface
import "../reprobuild-packages/packages/interfaces/bitwarden-cli/repro" as bitwardenCliInterface
import "../reprobuild-packages/packages/interfaces/bottom/repro" as bottomInterface
import "../reprobuild-packages/packages/interfaces/btop/repro" as btopInterface
import "../reprobuild-packages/packages/interfaces/busybox/repro" as busyboxInterface
import repro_dsl_stdlib/packages/cachix as cachixInterface
import "../reprobuild-packages/packages/interfaces/capitaine-cursors/repro" as capitaineCursorsInterface
import repro_dsl_stdlib/packages/claude_code as claudeCodeInterface
import "../reprobuild-packages/packages/interfaces/clion/repro" as clionInterface
import repro_dsl_stdlib/packages/cmake as cmakeInterface
import "../reprobuild-packages/packages/interfaces/codex/repro" as codexInterface
import "../reprobuild-packages/packages/interfaces/coreutils/repro" as coreutilsInterface
import repro_dsl_stdlib/packages/ctags as ctagsInterface
import repro_dsl_stdlib/packages/curl as curlInterface
import "../reprobuild-packages/packages/interfaces/cursor/repro" as cursorInterface
import "../reprobuild-packages/packages/interfaces/cursor-cli/repro" as cursorCliInterface
import "../reprobuild-packages/packages/interfaces/dbeaver/repro" as dbeaverInterface
import "../reprobuild-packages/packages/interfaces/dejavu-fonts/repro" as dejavuFontsInterface
import "../reprobuild-packages/packages/interfaces/delta/repro" as deltaInterface
import "../reprobuild-packages/packages/interfaces/devcontainer/repro" as devcontainerInterface
import "../reprobuild-packages/packages/interfaces/direnv/repro" as direnvInterface
import "../reprobuild-packages/packages/interfaces/discord/repro" as discordInterface
import "../reprobuild-packages/packages/interfaces/dropbox-cli/repro" as dropboxCliInterface
import "../reprobuild-packages/packages/interfaces/dua/repro" as duaInterface
import "../reprobuild-packages/packages/interfaces/evtest/repro" as evtestInterface
import "../reprobuild-packages/packages/interfaces/fd/repro" as fdInterface
import repro_dsl_stdlib/packages/ffmpeg as ffmpegInterface
import "../reprobuild-packages/packages/interfaces/fh/repro" as fhInterface
import "../reprobuild-packages/packages/interfaces/figma/repro" as figmaInterface
import "../reprobuild-packages/packages/interfaces/firefox/repro" as firefoxInterface
import "../reprobuild-packages/packages/interfaces/foot/repro" as footInterface
import "../reprobuild-packages/packages/interfaces/freerdp/repro" as freerdpInterface
import "../reprobuild-packages/packages/interfaces/frida-tools/repro" as fridaToolsInterface
import "../reprobuild-packages/packages/interfaces/fuzzel/repro" as fuzzelInterface
import "../reprobuild-packages/packages/interfaces/fzf/repro" as fzfInterface
import "../reprobuild-packages/packages/interfaces/gdb/repro" as gdbInterface
import "../reprobuild-llm-agent-packages/packages/interfaces/gemini-cli/repro" as geminiCliInterface
import repro_dsl_stdlib/packages/gh as ghInterface
import "../reprobuild-packages/packages/interfaces/ghidra/repro" as ghidraInterface
import "../reprobuild-packages/packages/interfaces/ghostty/repro" as ghosttyInterface
import "../reprobuild-packages/packages/interfaces/gimp/repro" as gimpInterface
import repro_dsl_stdlib/packages/git as gitInterface
import "../reprobuild-packages/packages/interfaces/git-lfs/repro" as gitLfsInterface
import "../reprobuild-packages/packages/interfaces/gitkraken/repro" as gitkrakenInterface
import "../reprobuild-packages/packages/interfaces/gnome-themes-extra/repro" as gnomeThemesExtraInterface
import "../reprobuild-packages/packages/interfaces/gnome-tweaks/repro" as gnomeTweaksInterface
import "../reprobuild-packages/packages/interfaces/gnupg/repro" as gnupgInterface
import "../reprobuild-packages/packages/interfaces/google-chrome/repro" as googleChromeInterface
import "../reprobuild-packages/packages/interfaces/google-cloud-sdk/repro" as googleCloudSdkInterface
import "../reprobuild-packages/packages/interfaces/gopass/repro" as gopassInterface
import "../reprobuild-packages/packages/interfaces/gopls/repro" as goplsInterface
import "../reprobuild-packages/packages/interfaces/helix/repro" as helixInterface
import "../reprobuild-packages/packages/interfaces/htop/repro" as htopInterface
import "../reprobuild-packages/packages/interfaces/hyprland/repro" as hyprlandInterface
import "../reprobuild-packages/packages/interfaces/hyprlock/repro" as hyprlockInterface
import "../reprobuild-packages/packages/interfaces/inetutils/repro" as inetutilsInterface
import "../reprobuild-packages/packages/interfaces/inkscape/repro" as inkscapeInterface
import "../reprobuild-packages/packages/interfaces/ipbt/repro" as ipbtInterface
import repro_dsl_stdlib/packages/jdk as jdkInterface
import "../reprobuild-packages/packages/interfaces/jjui/repro" as jjuiInterface
import repro_dsl_stdlib/packages/jq as jqInterface
import "../reprobuild-packages/packages/interfaces/jujutsu/repro" as jujutsuInterface
import repro_dsl_stdlib/packages/just as justInterface
import "../reprobuild-packages/packages/interfaces/kdiff3/repro" as kdiff3Interface
import "../reprobuild-packages/packages/interfaces/kernelshark/repro" as kernelsharkInterface
import "../reprobuild-packages/packages/interfaces/keybase/repro" as keybaseInterface
import "../reprobuild-packages/packages/interfaces/kitty/repro" as kittyInterface
import "../reprobuild-packages/packages/interfaces/lazygit/repro" as lazygitInterface
import "../reprobuild-packages/packages/interfaces/ledger-wallet/repro" as ledgerWalletInterface
import "../reprobuild-packages/packages/interfaces/libinput/repro" as libinputInterface
import "../reprobuild-packages/packages/interfaces/libreoffice/repro" as libreofficeInterface
import "../reprobuild-packages/packages/interfaces/llvm/repro" as llvmInterface
import "../reprobuild-packages/packages/interfaces/mako/repro" as makoInterface
import "../reprobuild-packages/packages/interfaces/man-db/repro" as manDbInterface
import "../reprobuild-packages/packages/interfaces/mc/repro" as mcInterface
import "../reprobuild-packages/packages/interfaces/meld/repro" as meldInterface
import "../reprobuild-packages/packages/interfaces/mercurial/repro" as mercurialInterface
import "../reprobuild-packages/packages/interfaces/mitmproxy/repro" as mitmproxyInterface
import "../reprobuild-packages/packages/interfaces/mosh/repro" as moshInterface
import "../reprobuild-packages/packages/interfaces/mutagen/repro" as mutagenInterface
import "../reprobuild-packages/packages/interfaces/ncdu/repro" as ncduInterface
import repro_dsl_stdlib/packages/neovim as neovimInterface
import "../reprobuild-packages/packages/interfaces/neovim-qt/repro" as neovimQtInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-0xproto/repro" as nerdFonts0xprotoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-3270/repro" as nerdFonts3270Interface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-adwaita-mono/repro" as nerdFontsAdwaitaMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-agave/repro" as nerdFontsAgaveInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-anonymice/repro" as nerdFontsAnonymiceInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-arimo/repro" as nerdFontsArimoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-atkynson-mono/repro" as nerdFontsAtkynsonMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-aurulent-sans-mono/repro" as nerdFontsAurulentSansMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-bigblue-terminal/repro" as nerdFontsBigblueTerminalInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-bitstream-vera-sans-mono/repro" as nerdFontsBitstreamVeraSansMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-blex-mono/repro" as nerdFontsBlexMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-caskaydia-cove/repro" as nerdFontsCaskaydiaCoveInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-caskaydia-mono/repro" as nerdFontsCaskaydiaMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-code-new-roman/repro" as nerdFontsCodeNewRomanInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-comic-shanns-mono/repro" as nerdFontsComicShannsMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-commit-mono/repro" as nerdFontsCommitMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-cousine/repro" as nerdFontsCousineInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-d2coding/repro" as nerdFontsD2codingInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-daddy-time-mono/repro" as nerdFontsDaddyTimeMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-dejavu-sans-mono/repro" as nerdFontsDejavuSansMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-departure-mono/repro" as nerdFontsDepartureMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-droid-sans-mono/repro" as nerdFontsDroidSansMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-envy-code-r/repro" as nerdFontsEnvyCodeRInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-fantasque-sans-mono/repro" as nerdFontsFantasqueSansMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-fira-code/repro" as nerdFontsFiraCodeInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-fira-mono/repro" as nerdFontsFiraMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-geist-mono/repro" as nerdFontsGeistMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-go-mono/repro" as nerdFontsGoMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-gohufont/repro" as nerdFontsGohufontInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-hack/repro" as nerdFontsHackInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-hasklug/repro" as nerdFontsHasklugInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-heavy-data/repro" as nerdFontsHeavyDataInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-hurmit/repro" as nerdFontsHurmitInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-im-writing/repro" as nerdFontsImWritingInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-inconsolata/repro" as nerdFontsInconsolataInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-inconsolata-go/repro" as nerdFontsInconsolataGoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-inconsolata-lgc/repro" as nerdFontsInconsolataLgcInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-intone-mono/repro" as nerdFontsIntoneMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-iosevka/repro" as nerdFontsIosevkaInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-iosevka-term/repro" as nerdFontsIosevkaTermInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-iosevka-term-slab/repro" as nerdFontsIosevkaTermSlabInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-jetbrains-mono/repro" as nerdFontsJetbrainsMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-lekton/repro" as nerdFontsLektonInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-liberation/repro" as nerdFontsLiberationInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-lilex/repro" as nerdFontsLilexInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-martian-mono/repro" as nerdFontsMartianMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-meslo-lg/repro" as nerdFontsMesloLgInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-monaspace/repro" as nerdFontsMonaspaceInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-monofur/repro" as nerdFontsMonofurInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-monoid/repro" as nerdFontsMonoidInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-mononoki/repro" as nerdFontsMononokiInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-mplus/repro" as nerdFontsMplusInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-noto/repro" as nerdFontsNotoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-open-dyslexic/repro" as nerdFontsOpenDyslexicInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-overpass/repro" as nerdFontsOverpassInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-profont/repro" as nerdFontsProfontInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-proggy-clean-tt/repro" as nerdFontsProggyCleanTtInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-recursive-mono/repro" as nerdFontsRecursiveMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-roboto-mono/repro" as nerdFontsRobotoMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-sauce-code-pro/repro" as nerdFontsSauceCodeProInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-shure-tech-mono/repro" as nerdFontsShureTechMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-space-mono/repro" as nerdFontsSpaceMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-symbols-only/repro" as nerdFontsSymbolsOnlyInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-terminess-ttf/repro" as nerdFontsTerminessTtfInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-tinos/repro" as nerdFontsTinosInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-ubuntu/repro" as nerdFontsUbuntuInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-ubuntu-mono/repro" as nerdFontsUbuntuMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-ubuntu-sans/repro" as nerdFontsUbuntuSansInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-victor-mono/repro" as nerdFontsVictorMonoInterface
import "../reprobuild-packages/packages/interfaces/nerd-fonts-zed-mono/repro" as nerdFontsZedMonoInterface
import "../reprobuild-packages/packages/interfaces/netbird/repro" as netbirdInterface
import "../reprobuild-packages/packages/interfaces/netbird-ui/repro" as netbirdUiInterface
import "../reprobuild-packages/packages/interfaces/nimlangserver/repro" as nimlangserverInterface
import "../reprobuild-packages/packages/interfaces/nix-tree/repro" as nixTreeInterface
import "../reprobuild-packages/packages/interfaces/nix-zsh-completions/repro" as nixZshCompletionsInterface
import "../reprobuild-packages/packages/interfaces/nss/repro" as nssInterface
import "../reprobuild-packages/packages/interfaces/nurl/repro" as nurlInterface
import "../reprobuild-packages/packages/interfaces/oh-my-zsh/repro" as ohMyZshInterface
import "../reprobuild-llm-agent-packages/packages/interfaces/opencode/repro" as opencodeInterface
import "../reprobuild-packages/packages/interfaces/ovh-ttyrec/repro" as ovhTtyrecInterface
import "../reprobuild-packages/packages/interfaces/patchelf/repro" as patchelfInterface
import "../reprobuild-packages/packages/interfaces/pgadmin/repro" as pgadminInterface
import "../reprobuild-packages/packages/interfaces/pinentry/repro" as pinentryInterface
import "../reprobuild-packages/packages/interfaces/psmisc/repro" as psmiscInterface
import "../reprobuild-packages/packages/interfaces/qemu-user/repro" as qemuUserInterface
import "../reprobuild-packages/packages/interfaces/qiling/repro" as qilingInterface
import "../reprobuild-packages/packages/interfaces/radare2/repro" as radare2Interface
import "../reprobuild-packages/packages/interfaces/realvnc-vnc-viewer/repro" as realvncVncViewerInterface
import "../reprobuild-packages/packages/interfaces/remmina/repro" as remminaInterface
import "../reprobuild-packages/packages/interfaces/repomix/repro" as repomixInterface
import repro_dsl_stdlib/packages/rg as rgInterface
import "../reprobuild-packages/packages/interfaces/rr/repro" as rrInterface
import repro_dsl_stdlib/packages/rust_analyzer as rustAnalyzerInterface
import "../reprobuild-packages/packages/interfaces/rustrover/repro" as rustroverInterface
import repro_dsl_stdlib/packages/shared_mime_info as sharedMimeInfoInterface
import "../reprobuild-packages/packages/interfaces/showmethekey/repro" as showmethekeyInterface
import "../reprobuild-packages/packages/interfaces/signal/repro" as signalInterface
import "../reprobuild-packages/packages/interfaces/slack/repro" as slackInterface
import "../reprobuild-packages/packages/interfaces/spotify/repro" as spotifyInterface
import "../reprobuild-packages/packages/interfaces/sqlitebrowser/repro" as sqlitebrowserInterface
import "../reprobuild-packages/packages/interfaces/sshfs/repro" as sshfsInterface
import "../reprobuild-packages/packages/interfaces/starship/repro" as starshipInterface
import "../reprobuild-packages/packages/interfaces/steam/repro" as steamInterface
import "../reprobuild-packages/packages/interfaces/swaylock/repro" as swaylockInterface
import "../reprobuild-packages/packages/interfaces/swaynotificationcenter/repro" as swaynotificationcenterInterface
import "../reprobuild-packages/packages/interfaces/telegram/repro" as telegramInterface
import "../reprobuild-packages/packages/interfaces/thunar/repro" as thunarInterface
import "../reprobuild-packages/packages/interfaces/thunderbird/repro" as thunderbirdInterface
import "../reprobuild-packages/packages/interfaces/tigervnc/repro" as tigervncInterface
import "../reprobuild-packages/packages/interfaces/tilix/repro" as tilixInterface
import repro_dsl_stdlib/packages/tmux as tmuxInterface
import "../reprobuild-packages/packages/interfaces/tmuxinator/repro" as tmuxinatorInterface
import "../reprobuild-packages/packages/interfaces/tor/repro" as torInterface
import "../reprobuild-packages/packages/interfaces/trace-cmd/repro" as traceCmdInterface
import "../reprobuild-packages/packages/interfaces/transmission/repro" as transmissionInterface
import repro_dsl_stdlib/packages/tree_sitter as treeSitterInterface
import "../reprobuild-packages/packages/interfaces/util-linux/repro" as utilLinuxInterface
import "../reprobuild-packages/packages/interfaces/valgrind/repro" as valgrindInterface
import "../reprobuild-packages/packages/interfaces/viber/repro" as viberInterface
import repro_dsl_stdlib/packages/vim as vimInterface
import "../reprobuild-packages/packages/interfaces/vlc/repro" as vlcInterface
import "../reprobuild-packages/packages/interfaces/vscode/repro" as vscodeInterface
import "../reprobuild-packages/packages/interfaces/waybar/repro" as waybarInterface
import "../reprobuild-packages/packages/interfaces/wev/repro" as wevInterface
import repro_dsl_stdlib/packages/wget as wgetInterface
import "../reprobuild-packages/packages/interfaces/wireshark/repro" as wiresharkInterface
import "../reprobuild-packages/packages/interfaces/wofi/repro" as wofiInterface
import "../reprobuild-packages/packages/interfaces/xclip/repro" as xclipInterface
import "../reprobuild-packages/packages/interfaces/xdg-desktop-portal/repro" as xdgDesktopPortalInterface
import "../reprobuild-packages/packages/interfaces/xdg-desktop-portal-hyprland/repro" as xdgDesktopPortalHyprlandInterface
import "../reprobuild-packages/packages/interfaces/xwayland/repro" as xwaylandInterface
import "../reprobuild-packages/packages/interfaces/yq/repro" as yqInterface
import "../reprobuild-packages/packages/interfaces/zed-editor/repro" as zedEditorInterface
import "../reprobuild-packages/packages/interfaces/zellij/repro" as zellijInterface
import "../reprobuild-packages/packages/interfaces/zoom/repro" as zoomInterface
import "../reprobuild-packages/packages/interfaces/zoxide/repro" as zoxideInterface
import "../reprobuild-packages/packages/interfaces/zplug/repro" as zplugInterface
import "../reprobuild-packages/packages/interfaces/zsh/repro" as zshInterface

provisioningFor "age":
  interfaceFingerprint "a6c791c8967221fe4c4cca4b8f157b05c46070b0382117a7840693beba206de7"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#age", executablePath = "bin/age",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "asciinema":
  interfaceFingerprint "4e8d269ae634f2725093a0276630ecc664530ff75da032bfe449361b4d25d9d6"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#asciinema", executablePath = "bin/asciinema",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "attic-client":
  interfaceFingerprint "445e3334aa6887ba4f31a9ed6f21d55984da5791f2a0f65cfcf19490ac907d67"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#attic-client", executablePath = "bin/attic",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "awscli":
  interfaceFingerprint "77ae3cfc307c515c14c84a8ad965220aa429ffcd5d89a53d8bf84559668fb42a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#awscli", executablePath = "bin/aws",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "bash":
  interfaceFingerprint "2df0cc8d7d9f6c4c315a70285271073e6b76ef48d4658b8bc5ad3a44d5ce72ff"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#bash", executablePath = "bin/bash",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "bfg-repo-cleaner":
  interfaceFingerprint "bac77cbbcb25f89358cb3ebc137490d34a4ac25dcfe135ab6c4e5a0b8b6cb3b6"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#bfg-repo-cleaner", executablePath = "bin/bfg",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "bitwarden":
  interfaceFingerprint "7bb554aeaf0a3e6849ebb41dda64b766ced5405f7eab029c96154c1eab8a8879"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#bitwarden-desktop", executablePath = "bin/bitwarden",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "bitwarden-cli":
  interfaceFingerprint "dd52376fbaf46823e9354d79dda95b492c5ca10f4fe9385d7638a26a870197f0"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#bitwarden-cli", executablePath = "bin/bw",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "bottom":
  interfaceFingerprint "14f06626acb66c7d0d40d90a5dfea7d352e26f80cb02ce52e5d9f35f745d86cf"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#bottom", executablePath = "bin/btm",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "btop":
  interfaceFingerprint "5ac0b092ad2d48666ba805893a4f4d41727bae6090f4a2d04dec1ff335f36cc5"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#btop", executablePath = "bin/btop",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "busybox":
  interfaceFingerprint "405d24965128e720003d633e1e635a2f8f4a290c8b64968511166c8ceb6c0432"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#busybox", executablePath = "bin/busybox",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "cachix":
  interfaceFingerprint "9b97a66d885932f6f06978569028efa4e6fba00f1d4ced95803d69bb62cdc104"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#cachix", executablePath = "bin/cachix",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "capitaine-cursors":
  interfaceFingerprint "33ba3a56ec1c6897d4d5af558f812c694132cda5a3cc403920069515eacdf8a6"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#capitaine-cursors", executablePath = "share/icons/capitaine-cursors-white/index.theme",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "claude-code":
  interfaceFingerprint "ed0d2908ad9553d858c1b4c8ed572d8196e0d751a72436653119e00fbd801346"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#claude-code", executablePath = "bin/claude",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "clion":
  interfaceFingerprint "2fb5f0c752de048397b2164ad7f7b659557e347a316c8224c6b671e7ad8a1b53"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#jetbrains.clion", executablePath = "bin/clion",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "cmake":
  interfaceFingerprint "46e387d9a093ed42f24c20b5c4d647ca6af7d429604aa7012befa6c83267bd35"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#cmake", executablePath = "bin/cmake",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "codex":
  interfaceFingerprint "5f10bc6323dc999df7dd609ac35ac98be8d9086598198a17d228f6de96092d0e"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#codex", executablePath = "bin/codex",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "coreutils":
  interfaceFingerprint "5727ee20f8d4e28f9fa0d5eefd739ce3040e9cfc3d24840c87199b2dc9bf2041"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#coreutils", executablePath = "bin/ls",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "ctags":
  interfaceFingerprint "59bd4c2bb1f6578c974865186287ffda03338804c942fed6019ab74358b33e6b"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#universal-ctags", executablePath = "bin/ctags",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "curl":
  interfaceFingerprint "868465f5351412cebfe472ff046a57040aa436f0611381d5eedb7bb170ae7af1"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#curl", executablePath = "bin/curl",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "cursor":
  interfaceFingerprint "8dd554281084bff16420c3d253d7414115f41fc6ca153d6b7c4bcbb655114069"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#code-cursor", executablePath = "bin/cursor",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "cursor-cli":
  interfaceFingerprint "47349cceb176b50ec8f9af0c89d6d52e97f83d642d62e6e414047fe18b404fa2"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#cursor-cli", executablePath = "bin/cursor-agent",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "dbeaver":
  interfaceFingerprint "98104669bfa3a45bd9bb7cdb1ae9f47e85960f8ceca06eeb9369f077efcba92c"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#dbeaver-bin", executablePath = "bin/dbeaver",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "dejavu-fonts":
  interfaceFingerprint "c6a116816ce134693d37e2f4e0e24c4f0283a202c665999e0b3c51e9a0f0e097"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#dejavu_fonts", executablePath = "share/fonts/truetype/DejaVuSans.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "delta":
  interfaceFingerprint "995920628c1f345df11f26e6523461051576ada3f5fa0eabb8bb40d8a7246844"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#delta", executablePath = "bin/delta",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "devcontainer":
  interfaceFingerprint "4dea0052d9c70c5e91a38e78fb214d61dbf472f5281c51a0bd4768b36a7dec32"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#devcontainer", executablePath = "bin/devcontainer",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "direnv":
  interfaceFingerprint "c9b6a596a413290fe7387bc3b5c8aa9fe5f3e27a59445877f119c9bf659a51a9"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#direnv", executablePath = "bin/direnv",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "discord":
  interfaceFingerprint "65422a2af33f641bae22967bde3a3ac28828b40fc77abf13d8a144e3b4f21deb"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#discord", executablePath = "bin/Discord",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "dropbox-cli":
  interfaceFingerprint "2c0c2534ae18ca68e52b42eef6c721483f92b1c42799ccc78f2bc42d250eb5f8"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#dropbox-cli", executablePath = "bin/dropbox",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "dua":
  interfaceFingerprint "623bcaadc3aced1371e852f10b09ad9408cbf5da9c797eec46495f778285469e"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#dua", executablePath = "bin/dua",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "evtest":
  interfaceFingerprint "174da79a8174edcbce40351fa69baea58e44ed4b1c30d1c8d8401b0c021bf282"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#evtest", executablePath = "bin/evtest",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "fd":
  interfaceFingerprint "64131949f09e5274552fd2fe4bd75a08605633ba6572aa1360baf773c10ee417"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#fd", executablePath = "bin/fd",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "ffmpeg":
  interfaceFingerprint "f704998536ee6d9b00f3c3a7e1d4226d3d2b017b4d780649e2ca9f044658856a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#ffmpeg", executablePath = "bin/ffmpeg",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "fh":
  interfaceFingerprint "b6cca869835d844c02d41e5ad0e3ea5774d35e89248dfa0fd02fd359d838133b"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#fh", executablePath = "bin/fh",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "figma":
  interfaceFingerprint "0a6c9ce906f240dbd956edec0fe1f65f667c64190ff838d2ab78cf1a12ef68de"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#figma-linux", executablePath = "bin/figma-linux",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "firefox":
  interfaceFingerprint "99a11e04edd5b1d7c568b3890403cd7e9680e65aa515d4e65c1ee89722375e1d"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#firefox", executablePath = "bin/firefox",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "foot":
  interfaceFingerprint "acfe651246f81a5451e4f295cce96f5899fafaf375c13de105cec9430774b427"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#foot", executablePath = "bin/foot",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "freerdp":
  interfaceFingerprint "898f121813969d70ca566227c803d1a26257d54b86a5b3f363dbce1effb73548"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#freerdp", executablePath = "bin/xfreerdp",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "frida-tools":
  interfaceFingerprint "61e4c62b65d90b45863dfb23d9df71ca8a3321e52ed8664d4593a934893db0b8"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#frida-tools", executablePath = "bin/frida",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "fuzzel":
  interfaceFingerprint "9059d8ddb3dacd831685905aeffff5f1656853fd1f7bedea7e7fad6715b2181e"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#fuzzel", executablePath = "bin/fuzzel",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "fzf":
  interfaceFingerprint "d69023e12c7bc0e99e2b210e190766c51d9adeec473d71f813c0e7df72d7bc08"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#fzf", executablePath = "bin/fzf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "gdb":
  interfaceFingerprint "87ef8b56c7e2997223113d10bdc05ee0e5577ccf51e09d402e1bfac5ee594f61"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#gdb", executablePath = "bin/gdb",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "gemini-cli":
  interfaceFingerprint "2119961f6fff3703b5b209738d122d0dcc154b7ac1957e34384eb8ec64d030cc"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#gemini-cli", executablePath = "bin/gemini",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "gh":
  interfaceFingerprint "93c7573a3eefc9f0af1ce9da82d34ba7fc2e349076d9b7911ccb684563786ac4"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#gh", executablePath = "bin/gh",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "ghidra":
  interfaceFingerprint "a6740a70861f18da90ef5b89bc1365f0550cbd3ea3a47e0c512f046b0bc2f0bd"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#ghidra", executablePath = "bin/ghidra",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "ghostty":
  interfaceFingerprint "d44788aef18ea078e8b4fcd5f110cb5810a5a87d82c2d547b970abf4dfa197dc"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#ghostty", executablePath = "bin/ghostty",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "gimp":
  interfaceFingerprint "18eb65e4b4ef4b21de550120e1f220291a77974fdeec0a980392683c6be2fe7f"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#gimp", executablePath = "bin/gimp",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "git":
  interfaceFingerprint "89d1f053f479cc8343138c26a839e5a6bf079551bdd3a6db67764472493b2ae2"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#git", executablePath = "bin/git",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "git-lfs":
  interfaceFingerprint "6cdbd44418aa2074e3099a0a4bfb0123871987e4de7a75233162f6cf80e3c78a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#git-lfs", executablePath = "bin/git-lfs",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "gitkraken":
  interfaceFingerprint "90ede9783b161b32284f4a5ca8ccc980f8f200fa6c9bf1b00282f632633340b7"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#gitkraken", executablePath = "bin/gitkraken",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "gnome-themes-extra":
  interfaceFingerprint "8c682462f466563d6a44900489f9e9d9aeaee10f1b8fe3f3dba6ec4dfdfaa2a9"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#gnome-themes-extra", executablePath = "share/themes/Adwaita-dark/gtk-2.0/gtkrc",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "gnome-tweaks":
  interfaceFingerprint "6ae376040fb1b78a88870a56db787d30decc76c9a077fa292c119e1a55f9224d"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#gnome-tweaks", executablePath = "bin/gnome-tweaks",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "gnupg":
  interfaceFingerprint "72ceff5acedfe5a7a1f15c2f1463308fc3864d4eeec0d626b22000ff3177b416"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#gnupg", executablePath = "bin/gpg",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "google-chrome":
  interfaceFingerprint "07b8e2b2f20e616a06e3ca26094aac738538bb7d83d28890f3868b02fe7c197a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#google-chrome", executablePath = "bin/google-chrome-stable",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "google-cloud-sdk":
  interfaceFingerprint "be07f7accb96237b271d8b6f5d92be319f7b2bfb9393d1a9d021082f01fcef3d"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#google-cloud-sdk", executablePath = "bin/gcloud",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "gopass":
  interfaceFingerprint "f5708ad7461f912fbc51e1b9b2ea7a82314ccd121995857579ff5b41f657cae5"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#gopass", executablePath = "bin/gopass",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "gopls":
  interfaceFingerprint "e29eeb9b9ae0f3958b967e907b752a55c41d1bb786b0615a1c5eaa1dd6a40840"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#gopls", executablePath = "bin/gopls",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "helix":
  interfaceFingerprint "dd343e53b66361f1ff8bfad4af5b4b4489104377ee259e5a8d48d0f71a01d9b2"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#helix", executablePath = "bin/hx",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "htop":
  interfaceFingerprint "422909aa10096999b3e458bc568bcc42fac4bf29272ef2582f887424c6f33a6a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#htop", executablePath = "bin/htop",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "hyprland":
  interfaceFingerprint "257cee72ad438047d9829902215c29cb17e2f7a7a78bde444215a21e779c84ac"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#hyprland", executablePath = "bin/Hyprland",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "hyprlock":
  interfaceFingerprint "5a9818ca476653ebc86e630d3596588fc5c9466a8cbcc20768c91c8a9a413e8c"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#hyprlock", executablePath = "bin/hyprlock",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "inetutils":
  interfaceFingerprint "af0d167b0ec78df14dfcfb898f3fb2b8aa721b24d910be36398fa1f709b1737a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#inetutils", executablePath = "bin/telnet",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "inkscape":
  interfaceFingerprint "de81490859b583facf96516035bb798f2685b5e49271dc217f7b2ea007684d45"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#inkscape", executablePath = "bin/inkscape",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "ipbt":
  interfaceFingerprint "cfe563a93595ff0ef9fef9666dc78886c7a020bffb94029f602f8d6f36940154"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#ipbt", executablePath = "bin/ipbt",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "jdk":
  interfaceFingerprint "afc0a39a7be6a642e5a99b2a65ae0650f53c4ccc6a4b0b3a9fd94b1a77547078"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#temurin-bin", executablePath = "bin/java",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "jjui":
  interfaceFingerprint "d1e70d871280315a5874f7e0ef7185df53382bdac565a5ad779322b4888955e2"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#jjui", executablePath = "bin/jjui",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "jq":
  interfaceFingerprint "8e0baf4cbd6c8efee6319b6a7e18a8fd1ff01f7ee85da09f188b8a8b4a1f91f5"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#jq", executablePath = "bin/jq",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "jujutsu":
  interfaceFingerprint "d3d850febda770a64f0c70c08a9a72c0df0ffc16bdbb338dc067653f28397b69"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#jujutsu", executablePath = "bin/jj",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "just":
  interfaceFingerprint "5b32e1533f04e26a88cb37c996cafbe3b158278dc61c354c436df050538da7c5"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#just", executablePath = "bin/just",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "kdiff3":
  interfaceFingerprint "efa55820093552375c8a7f34933510a365708f07b3dbcaddd7bb3583ed9c6eda"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#kdiff3", executablePath = "bin/kdiff3",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "kernelshark":
  interfaceFingerprint "d224dc9f4fed711b2e69b11825246085fdc92dd49fc39160084af769628be921"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#kernelshark", executablePath = "bin/kernelshark",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "keybase":
  interfaceFingerprint "babaf75b324ca154538cc9099e71ac5454790cd4f4e771eb16b6d0d5d508edaa"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#keybase", executablePath = "bin/keybase",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "kitty":
  interfaceFingerprint "00258269ea3360c274385f8b53480e75fe4eee6c2eb772dd16eac9c48c79d227"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#kitty", executablePath = "bin/kitty",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "lazygit":
  interfaceFingerprint "96ca32a8570f8f25392b722f870efcd645d4607d6e353aa2432e1cb6de21fa4f"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#lazygit", executablePath = "bin/lazygit",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "ledger-wallet":
  interfaceFingerprint "487ce7e97ba72bef67ad9bb74fed74b750769d05725382cc6f949b1c7661df40"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#ledger-live-desktop", executablePath = "bin/ledger-live-desktop",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "libinput":
  interfaceFingerprint "c9fd377dc1eca0db53385d8061e56fdf86ee6a0c8d8a0bb7d09d12785df276bc"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#libinput", executablePath = "bin/libinput",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "libreoffice":
  interfaceFingerprint "f8bf7664e3636c6c308262aa9384bfb90d1d098f2279876470c66fae90f29925"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#libreoffice", executablePath = "bin/libreoffice",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "llvm":
  interfaceFingerprint "6d5d82b5ae0c070ca59169c28d6c0f21e08c0cc4039653d272a7dc0dc5fe0cbd"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#llvm.dev", executablePath = "bin/llvm-config",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "mako":
  interfaceFingerprint "49d1572b2e779f0e2ab1610024e7bdf420751c696f857beff0f47488ca94b37b"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#mako", executablePath = "bin/mako",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "man-db":
  interfaceFingerprint "09e23efd73b1ba11cf317ee073012aa384c5960ced57b4b46c57ea374ed0e60a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#man-db", executablePath = "bin/man",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "mc":
  interfaceFingerprint "d6f3e016aefd8ebe77812d6685db0876658867cd49e4cccf0e2c94719acf1876"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#mc", executablePath = "bin/mc",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "meld":
  interfaceFingerprint "3ac15e3b27d4235cbd546d71db8f078a890762e661338afa8eeaa4326398a90a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#meld", executablePath = "bin/meld",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "mercurial":
  interfaceFingerprint "3ecb201c4ebea99f33cbd592e22b9b67642c6ca7728832e7adce767395316617"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#mercurial", executablePath = "bin/hg",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "mitmproxy":
  interfaceFingerprint "11f5ad84c325d97d430e7aa720ec70ac4fd67ee2023d1d792d25050a5c2af622"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#mitmproxy", executablePath = "bin/mitmproxy",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "mosh":
  interfaceFingerprint "c8dadcbd3787e41d2f9c411afd2d4ba1dee0c075e86da62bc6f71cf0c46c6edb"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#mosh", executablePath = "bin/mosh",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "mutagen":
  interfaceFingerprint "846b98b13c434618157eb7b96ef58016494c88f16aa0a0cbb7bfd9ea1f74edf9"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#mutagen", executablePath = "bin/mutagen",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "ncdu":
  interfaceFingerprint "a602c8c2f1e0a25d7d67e5634eebd4a9a5844dc904c90b2e8235fd0ff88a9f61"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#ncdu", executablePath = "bin/ncdu",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "neovim":
  interfaceFingerprint "fedf60bc3ef933868ab6fa2a60047c34513556146fcaa656bb978013ab286111"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#neovim", executablePath = "bin/nvim",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "neovim-qt":
  interfaceFingerprint "838d3b445a19e9b8abe6e69f6d4d37f4b8bb2c386c9193c2bf597a088c75ee8b"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#neovim-qt", executablePath = "bin/nvim-qt",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-0xproto":
  interfaceFingerprint "2cad4e2e284ad722f993ff630d03d646514d50273f277f55491d9e3ed75f061a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts._0xproto", executablePath = "share/fonts/truetype/NerdFonts/0xProto/0xProtoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-3270":
  interfaceFingerprint "ede0a99d2f1cd1e687026302a632c078eea04ca75fa8dfa07be1f507a1c3f39b"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts._3270", executablePath = "share/fonts/truetype/NerdFonts/3270/3270NerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-adwaita-mono":
  interfaceFingerprint "58889679e591dc9c9f375393dea3f0a1cba934e9f487cfd340bd7c85dea5f44e"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.adwaita-mono", executablePath = "share/fonts/truetype/NerdFonts/AdwaitaMono/AdwaitaMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-agave":
  interfaceFingerprint "67a295eb9a666f3868192566844fe203b45e8bd6fb469fcb73a69cb7cc9ab6a6"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.agave", executablePath = "share/fonts/truetype/NerdFonts/Agave/AgaveNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-anonymice":
  interfaceFingerprint "3a9261ee7df0dc87003827cb17b0d4bd45b3dc82f49e66a34227779ade80524f"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.anonymice", executablePath = "share/fonts/truetype/NerdFonts/AnonymicePro/AnonymiceProNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-arimo":
  interfaceFingerprint "3d995a24ecdad1aa0745d20de135072a7a496dc34b37736e1a6462b90751c5e5"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.arimo", executablePath = "share/fonts/truetype/NerdFonts/Arimo/ArimoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-atkynson-mono":
  interfaceFingerprint "0fba8fe9b66a6e196ecb65663802c4a25ebf27e0c14b1e2d950843f162997922"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.atkynson-mono", executablePath = "share/fonts/opentype/NerdFonts/AtkynsonMono/AtkynsonMonoNerdFont-Regular.otf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-aurulent-sans-mono":
  interfaceFingerprint "3f101a338098083e4ba0acabca5a8b50d916b76fdce72abaac47ac777bed5cd9"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.aurulent-sans-mono", executablePath = "share/fonts/opentype/NerdFonts/AurulentSansM/AurulentSansMNerdFont-Regular.otf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-bigblue-terminal":
  interfaceFingerprint "1d7ca3d8f6da10fd3ca9ed2ac4e82f696ce4ab1087c1b486b490f028b4eb3fdb"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.bigblue-terminal", executablePath = "share/fonts/truetype/NerdFonts/BigBlueTerm/BigBlueTerm437NerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-bitstream-vera-sans-mono":
  interfaceFingerprint "07cf5534fad479edf3db60beef65a57d0d950aeb357b8476513701171d240580"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.bitstream-vera-sans-mono", executablePath = "share/fonts/truetype/NerdFonts/BitstromWera/BitstromWeraNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-blex-mono":
  interfaceFingerprint "8021e4b33b2c8516d3108fcb99d34d95b5d0cf3bd72af6ae934e1a764844174c"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.blex-mono", executablePath = "share/fonts/truetype/NerdFonts/BlexMono/BlexMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-caskaydia-cove":
  interfaceFingerprint "3fba771e0487ed3578db18e844183b582c98dd3b4f1d9bba75005b378f43425a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.caskaydia-cove", executablePath = "share/fonts/truetype/NerdFonts/CaskaydiaCove/CaskaydiaCoveNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-caskaydia-mono":
  interfaceFingerprint "7d97aee7b57c55ccf26780f0e9b9f9b17c9ac888a42c61b99597b7310ad5d71d"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.caskaydia-mono", executablePath = "share/fonts/truetype/NerdFonts/CaskaydiaMono/CaskaydiaMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-code-new-roman":
  interfaceFingerprint "c483f54d28acad4307bf198ccc4bd9bbde79deaf67ca2375d8d893dc2befb62e"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.code-new-roman", executablePath = "share/fonts/opentype/NerdFonts/CodeNewRoman/CodeNewRomanNerdFont-Regular.otf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-comic-shanns-mono":
  interfaceFingerprint "a127b048a43efb523d4667f42e781ea76534093e92eb17d8e8c31a3a8e16e96f"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.comic-shanns-mono", executablePath = "share/fonts/opentype/NerdFonts/ComicShannsMono/ComicShannsMonoNerdFont-Regular.otf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-commit-mono":
  interfaceFingerprint "a876dca4615d7722c20bb97803bca70d2f5dbd8a8725d6d6f04a88e21dd0565f"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.commit-mono", executablePath = "share/fonts/opentype/NerdFonts/CommitMono/CommitMonoNerdFont-Regular.otf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-cousine":
  interfaceFingerprint "cd001bb6b72d9fd99d7e2844a90430250b2dc77c8d1e4221c7c47751c8403b77"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.cousine", executablePath = "share/fonts/truetype/NerdFonts/Cousine/CousineNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-d2coding":
  interfaceFingerprint "82cd719cab4ea072dc6b09f7f8495feff8a485e097de9363cd399e6484f92c7f"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.d2coding", executablePath = "share/fonts/truetype/NerdFonts/D2CodingLigature/D2CodingLigatureNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-daddy-time-mono":
  interfaceFingerprint "4cef2312ae6e32a346ef369f895c38393e440be2a3d4ada120047054e57e9c85"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.daddy-time-mono", executablePath = "share/fonts/truetype/NerdFonts/DaddyTimeMono/DaddyTimeMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-dejavu-sans-mono":
  interfaceFingerprint "a247adad72a9afd470a0b8dd7ce8ca64536c03e40e5178a9363b34aa3689160a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.dejavu-sans-mono", executablePath = "share/fonts/truetype/NerdFonts/DejaVuSansM/DejaVuSansMNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-departure-mono":
  interfaceFingerprint "2cf34a15165179715ddd4f6bf5aeec962b984e4dc98d68393d8aeefcd561b041"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.departure-mono", executablePath = "share/fonts/opentype/NerdFonts/DepartureMono/DepartureMonoNerdFont-Regular.otf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-droid-sans-mono":
  interfaceFingerprint "a35df4089b11dde277dcf3c47fab6be7d1edf5fd607572b5004f132537cd0a9f"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.droid-sans-mono", executablePath = "share/fonts/opentype/NerdFonts/DroidSansM/DroidSansMNerdFont-Regular.otf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-envy-code-r":
  interfaceFingerprint "39032636cba6ca6c2027ce940550f566ad3c3bf7be67632e69ae72dfd5797cce"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.envy-code-r", executablePath = "share/fonts/truetype/NerdFonts/EnvyCodeR/EnvyCodeRNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-fantasque-sans-mono":
  interfaceFingerprint "c317dabe4d693ea04dd778a0b5b92fc47acb795cf02999a516054d9c975a0cf9"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.fantasque-sans-mono", executablePath = "share/fonts/truetype/NerdFonts/FantasqueSansM/FantasqueSansMNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-fira-code":
  interfaceFingerprint "ec505b0c172f998e1b90b361c3aa06679a24a5ffee178d60641a8066e80745c6"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.fira-code", executablePath = "share/fonts/truetype/NerdFonts/FiraCode/FiraCodeNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-fira-mono":
  interfaceFingerprint "e78d837471c65b80bf79876a24fc5b1afa5162a58ec9d9250d4fbc5b3528fb15"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.fira-mono", executablePath = "share/fonts/opentype/NerdFonts/FiraMono/FiraMonoNerdFont-Regular.otf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-geist-mono":
  interfaceFingerprint "351e76ed220f66b5862a60e7d1b3b18f25c2e51d652e182b619ce372200439c9"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.geist-mono", executablePath = "share/fonts/opentype/NerdFonts/GeistMono/GeistMonoNerdFont-Regular.otf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-go-mono":
  interfaceFingerprint "8f1b2b042f12480875d1bf5f5145b15c10ad1f19c3f1ba6be29ae83fe2ede1f4"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.go-mono", executablePath = "share/fonts/truetype/NerdFonts/GoMono/GoMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-gohufont":
  interfaceFingerprint "f6f15f8ba7ca068fbb514d47a0a0b675fef267371fedd4a8657228e5285778ae"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.gohufont", executablePath = "share/fonts/truetype/NerdFonts/GohuFont/GohuFont11NerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-hack":
  interfaceFingerprint "492d3e092fcf5ccb6fc410b7e2d5aa4e8de9497214d0f3a920c2eb5e53ceb12f"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.hack", executablePath = "share/fonts/truetype/NerdFonts/Hack/HackNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-hasklug":
  interfaceFingerprint "0854ff011fe5b247540fd7fc33011f891f6da07614281abbc1d0d7264488aa8f"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.hasklug", executablePath = "share/fonts/opentype/NerdFonts/Hasklug/HasklugNerdFont-Regular.otf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-heavy-data":
  interfaceFingerprint "d86633a69f4ca4ee65dd41c15b769a2cc8c3c370e3bed03acd161a91a157346a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.heavy-data", executablePath = "share/fonts/truetype/NerdFonts/HeavyData/HeavyDataNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-hurmit":
  interfaceFingerprint "a0bbf9cef32b2fa93d93755e03ebcb4a6cd2d0a86de163d7d31f9f5c001faea3"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.hurmit", executablePath = "share/fonts/opentype/NerdFonts/Hurmit/HurmitNerdFont-Regular.otf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-im-writing":
  interfaceFingerprint "39e596c9fba22d5eb7565dfae82fd19dc997a1668fb7e5609249fbe9cec761bf"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.im-writing", executablePath = "share/fonts/truetype/NerdFonts/iMWriting/iMWritingDuoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-inconsolata":
  interfaceFingerprint "680aa02bfd2378035bc720d0dc28fbf38dfb036a2c779110a6ed7b75d3ac6e6c"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.inconsolata", executablePath = "share/fonts/truetype/NerdFonts/Inconsolata/InconsolataNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-inconsolata-go":
  interfaceFingerprint "35ac33ee8b4c9b700deca0451f09cbe988616903aaae78e619917df3c5aa8da2"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.inconsolata-go", executablePath = "share/fonts/truetype/NerdFonts/InconsolataGo/InconsolataGoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-inconsolata-lgc":
  interfaceFingerprint "3a025c2323ddfd2dac07c46336e0e32c9c60689951c55ae91447695a5bf1cbf4"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.inconsolata-lgc", executablePath = "share/fonts/truetype/NerdFonts/InconsolataLGC/InconsolataLGCNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-intone-mono":
  interfaceFingerprint "4676a2d23b64822faef778cec9c62e274cffb8a34fa476c14a161669f214da06"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.intone-mono", executablePath = "share/fonts/truetype/NerdFonts/IntoneMono/IntoneMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-iosevka":
  interfaceFingerprint "9954bcdaf516eee56dec834e58e541fafaeb1c6ecb13f7c1058606c69680c8a4"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.iosevka", executablePath = "share/fonts/truetype/NerdFonts/Iosevka/IosevkaNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-iosevka-term":
  interfaceFingerprint "4f6ea80e1950e4bc1e782c4aeaefa33cc587195c30c6068c04a7cc15d5b90f04"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.iosevka-term", executablePath = "share/fonts/truetype/NerdFonts/IosevkaTerm/IosevkaTermNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-iosevka-term-slab":
  interfaceFingerprint "57b59d7fe93fef9fb88a8239443468be75c080b22d66932284e146ee518aee94"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.iosevka-term-slab", executablePath = "share/fonts/truetype/NerdFonts/IosevkaTermSlab/IosevkaTermSlabNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-jetbrains-mono":
  interfaceFingerprint "7733aee70814df3cdf7249d5a72de9a3e1d03d426e299856623527084863f95d"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.jetbrains-mono", executablePath = "share/fonts/truetype/NerdFonts/JetBrainsMono/JetBrainsMonoNLNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-lekton":
  interfaceFingerprint "273164c9297b9f20f231f29279b3938a49d1ec307fbeeaccdae169f7fce37ff3"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.lekton", executablePath = "share/fonts/truetype/NerdFonts/Lekton/LektonNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-liberation":
  interfaceFingerprint "c74aba3d4b9f8ac9e06399a58f00f78de00308385f078553e01b4f0ef6d6dead"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.liberation", executablePath = "share/fonts/truetype/NerdFonts/LiterationMono/LiterationMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-lilex":
  interfaceFingerprint "effbc4cb57f3ce0dab6a75b663543635a69d85ce30731310d0a7ff62b006bee9"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.lilex", executablePath = "share/fonts/truetype/NerdFonts/Lilex/LilexNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-martian-mono":
  interfaceFingerprint "cdc367525662e01028709bd3155426565311fde46e7de9c4aed3109a7879466f"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.martian-mono", executablePath = "share/fonts/truetype/NerdFonts/MartianMono/MartianMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-meslo-lg":
  interfaceFingerprint "f6ac1b5b10e56e613ee40081053c7b5a85ea7fecc37c49c5655feb22f49344e7"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.meslo-lg", executablePath = "share/fonts/truetype/NerdFonts/MesloLG/MesloLGLDZNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-monaspace":
  interfaceFingerprint "b9747f4e4e66a1f6e40ae0775d1fb737dd9547ca8c653d3df10afd82114e58a3"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.monaspace", executablePath = "share/fonts/opentype/NerdFonts/Monaspice/MonaspiceArNerdFont-Regular.otf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-monofur":
  interfaceFingerprint "c2362474607b1922332fb39a22f74e2cfc036fb43bbed0eba52a459b3857d937"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.monofur", executablePath = "share/fonts/truetype/NerdFonts/Monofur/MonofurNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-monoid":
  interfaceFingerprint "feb29aa8c22b4ffbef44553f86b626d2d2f5d2c977726ce074b5b85885640b49"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.monoid", executablePath = "share/fonts/truetype/NerdFonts/Monoid/MonoidNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-mononoki":
  interfaceFingerprint "4eae88ab66fdf13076c680caf31e3ba2cb82e26cd30fe64dc0562c84bcc01af8"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.mononoki", executablePath = "share/fonts/truetype/NerdFonts/Mononoki/MononokiNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-mplus":
  interfaceFingerprint "c70910cd9b3f57c47f5c5557c07c082e55b25472b44c2f9c93dfe9fdd9d130b4"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.m+", executablePath = "share/fonts/truetype/NerdFonts/M+/M+1CodeNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-noto":
  interfaceFingerprint "4f7c4d2aec9073e77ee7f8c1d731ac467a029a2314f6ef9f9bd21ba66ae716b1"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.noto", executablePath = "share/fonts/truetype/NerdFonts/Noto/NotoMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-open-dyslexic":
  interfaceFingerprint "0c4cb804dd92ed2dcec9da095b90e624f9aa53ca08a771bf1d0f401e56f98f7b"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.open-dyslexic", executablePath = "share/fonts/opentype/NerdFonts/OpenDyslexic/OpenDyslexicAltNerdFont-Regular.otf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-overpass":
  interfaceFingerprint "f8766e6a277474e9cab4d4b8a51e1773104e809c3ee63c389a4225a93342b7dd"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.overpass", executablePath = "share/fonts/opentype/NerdFonts/Overpass/OverpassMNerdFont-Regular.otf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-profont":
  interfaceFingerprint "c30b5a6dcb8a0987399a590b37896af87108be3a3615185279d3291f9c242e2a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.profont", executablePath = "share/fonts/truetype/NerdFonts/ProFont/ProFontIIxNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-proggy-clean-tt":
  interfaceFingerprint "e290a0352a861116834c33411a92ccc00e31305fca004b89d9197f17797f16eb"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.proggy-clean-tt", executablePath = "share/fonts/truetype/NerdFonts/ProggyClean/ProggyCleanCENerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-recursive-mono":
  interfaceFingerprint "97d8feb5b1a2be2082988ad98a233e867a98cdc6d2990a5892f065b56a4b94ff"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.recursive-mono", executablePath = "share/fonts/truetype/NerdFonts/RecMono/RecMonoCasualNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-roboto-mono":
  interfaceFingerprint "687f3892da3ae49bca8b2f6a8e3296c2fcfc62f7cc0b1f40553722dfa0d07d43"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.roboto-mono", executablePath = "share/fonts/truetype/NerdFonts/RobotoMono/RobotoMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-sauce-code-pro":
  interfaceFingerprint "d96e6350c2048c1db8506bafdfb91f36237ff6ae549a4f418560a75cf30799e2"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.sauce-code-pro", executablePath = "share/fonts/truetype/NerdFonts/SauceCodePro/SauceCodeProNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-shure-tech-mono":
  interfaceFingerprint "1c579955d3733acb4d295b50c6a87283d10cd60ccf6ce0892f540a4b2a05a23a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.shure-tech-mono", executablePath = "share/fonts/truetype/NerdFonts/ShureTechMono/ShureTechMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-space-mono":
  interfaceFingerprint "c1d23ecd5c26323eb0646488b38bd64b76745b7f2949779eea4a44b977ec4675"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.space-mono", executablePath = "share/fonts/truetype/NerdFonts/SpaceMono/SpaceMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-symbols-only":
  interfaceFingerprint "0c69b1a4bd3f2e7ea5e6d29fb15939d81ab006e10aeee0fbc148ae2367dd2545"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.symbols-only", executablePath = "share/fonts/truetype/NerdFonts/Symbols/SymbolsNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-terminess-ttf":
  interfaceFingerprint "62e28c8cdfa5b8c5c732167d4f21038e8fc8d993972bd6f372d95156549877e7"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.terminess-ttf", executablePath = "share/fonts/truetype/NerdFonts/Terminess/TerminessNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-tinos":
  interfaceFingerprint "996980e1820582f1e47ed3f2a80fe59653a70e76350dc91eee6382c4704ac911"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.tinos", executablePath = "share/fonts/truetype/NerdFonts/Tinos/TinosNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-ubuntu":
  interfaceFingerprint "3f5da110c6f899e09827361f15054fb48810c2dd44ac987ccb25aa4beb050f9c"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.ubuntu", executablePath = "share/fonts/truetype/NerdFonts/Ubuntu/UbuntuNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-ubuntu-mono":
  interfaceFingerprint "6268c4599f660b18012aa51372052b03b1309d4a99995ee931b153e013edaa82"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.ubuntu-mono", executablePath = "share/fonts/truetype/NerdFonts/UbuntuMono/UbuntuMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-ubuntu-sans":
  interfaceFingerprint "3c1bd5b79652e40353900f8a15cb69c7628ac08ebc11f4889ac3f53a2f035efa"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.ubuntu-sans", executablePath = "share/fonts/truetype/NerdFonts/UbuntuSans/UbuntuSansMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-victor-mono":
  interfaceFingerprint "afeb4281ac80a674845f7730a0bf1363ec1be537a048308e5fcf9c5514a778c3"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.victor-mono", executablePath = "share/fonts/truetype/NerdFonts/VictorMono/VictorMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nerd-fonts-zed-mono":
  interfaceFingerprint "b59574ea2f8d333f8fe2871344ae23549728c761585b406bb862bcf499a7cb36"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nerd-fonts.zed-mono", executablePath = "share/fonts/truetype/NerdFonts/ZedMono/ZedMonoNerdFont-Regular.ttf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "netbird":
  interfaceFingerprint "2315cdd3a09e4380459180cfd800f11535e464cb9fbd8b82cc7af1687063dd92"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#netbird", executablePath = "bin/netbird",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "netbird-ui":
  interfaceFingerprint "bf09c356f99dd2865978a5d46a4a9c8a2d7a20457ae1ce2544da5fa52509326b"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#netbird-ui", executablePath = "bin/netbird-ui",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nimlangserver":
  interfaceFingerprint "53e2e765bdfd2cd2f0b5db169dfbd563c4008ad8e3f3b5daf539ddef9dcf5903"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nimlangserver", executablePath = "bin/nimlangserver",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nix-tree":
  interfaceFingerprint "2b514d82127fe0f44ebf2bb1f9e33eb80004313195891fc3a6084b3e2601acfa"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nix-tree", executablePath = "bin/nix-tree",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nix-zsh-completions":
  interfaceFingerprint "c13fd8a2981ffb64c17db15ef1df87b850b12e0dd8ae4a18225a9edd6be7d597"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nix-zsh-completions", executablePath = "share/zsh/plugins/nix/init.zsh",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nss":
  interfaceFingerprint "70256d86c2db9bb73c5fbadc5ed0303ab26bb6abe476a52031bf9401df76f5cf"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nss", executablePath = "lib/libnss3.so",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "nurl":
  interfaceFingerprint "1d6cd39818295581001046805e581ffc6af3ddd23b50174c621d7e324c400912"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#nurl", executablePath = "bin/nurl",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "oh-my-zsh":
  interfaceFingerprint "a3a9d0a0b72d9e436e0547d78ef6c50169eab9f47cddc013858762e61041d40a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#oh-my-zsh", executablePath = "share/oh-my-zsh/oh-my-zsh.sh",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "opencode":
  interfaceFingerprint "1bb893b6670012ac33ce2ba8db323c022ec1b2d01d31860924508fb0dcc44a6d"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#opencode", executablePath = "bin/opencode",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "ovh-ttyrec":
  interfaceFingerprint "eec0cf6b0204c12b3453b843d25243a7be8c2e88e512b18413ff7ad25b7d73fb"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#ovh-ttyrec", executablePath = "bin/ttyrec",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "patchelf":
  interfaceFingerprint "c3c0aed07dd83687b8e859f7f203e552cfd4bd75efabc16ccf2114781636c5a8"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#patchelf", executablePath = "bin/patchelf",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "pgadmin":
  interfaceFingerprint "13bbd5eda44ed1a18b9855a7068a97e01758c366ef1ad4e44a1381fdc6f0ffd6"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#pgadmin4", executablePath = "bin/pgadmin4",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "pinentry":
  interfaceFingerprint "57c1ef9c34d7f1d77aa954d09af5cb886e63ecd85ae32b86dc909087f936d5c4"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#pinentry-curses", executablePath = "bin/pinentry",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "psmisc":
  interfaceFingerprint "4e5e1cc57b9b23c340343e7e01c85ddb011352c95fb5ac651eec77cc82bd87c3"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#psmisc", executablePath = "bin/killall",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "qemu-user":
  interfaceFingerprint "775d1a0bd9305f3a65786bfe28525681913c9bf25a1afea8fd923a81d7bbb5f4"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#qemu-user", executablePath = "bin/qemu-x86_64",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "qiling":
  interfaceFingerprint "6e223bd1318e40b2b978e6ab43d97c7f96b66653fb189aab97985a31aadef1ab"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#python312Packages.qiling", executablePath = "bin/qltool",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "radare2":
  interfaceFingerprint "1fa0a3b91a34e40275dd99d076a49a9cd963d5f30643f9f39c2ad13b84ec5c9b"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#radare2", executablePath = "bin/radare2",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "realvnc-vnc-viewer":
  interfaceFingerprint "8cc0b52bce68363893e3038e447bbd272ec30fe66808136f58e61d5b4774a7cc"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#realvnc-vnc-viewer", executablePath = "bin/vncviewer",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "remmina":
  interfaceFingerprint "0c1383b2f695f9fac0ffa769d1c83c1e34fda20f60cf0120362c4ccf607f1990"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#remmina", executablePath = "bin/remmina",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "repomix":
  interfaceFingerprint "a7e32a06a647213928532e820c7a78edb06072f105c4574cd3102799569e406a"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#repomix", executablePath = "bin/repomix",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "rg":
  interfaceFingerprint "e26602971a6acc2f02fce834f670808dae6fe000642c8aced79e317ec9d6fe86"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#ripgrep", executablePath = "bin/rg",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "rr":
  interfaceFingerprint "85cb142d8bfee9621278794f0ea1867bad8993919b17cd3dfcd633d711a7e972"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#rr", executablePath = "bin/rr",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "rust-analyzer":
  interfaceFingerprint "1b914b5fe289eacdfbe6dd7b23783b057b75f190edf0487c23ca68d82a180a47"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#rust-analyzer", executablePath = "bin/rust-analyzer",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "rustrover":
  interfaceFingerprint "b8255c7c88d214ada7b28a3b196e353288b6315f023d64c8eee567da71c23877"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#jetbrains.rust-rover", executablePath = "bin/rust-rover",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "shared-mime-info":
  interfaceFingerprint "e3ce54d83807a9468e524694336cdda38c9387c31882625d8ec536b8549d32bc"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#shared-mime-info", executablePath = "bin/update-mime-database",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "showmethekey":
  interfaceFingerprint "ef03cbed2e4903b5fc6679ca0cd40ca650389f27694cbe16dcfa2186244c82ed"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#showmethekey", executablePath = "bin/showmethekey-gtk",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "signal":
  interfaceFingerprint "fadf54bca39b6882281466d3bd6a18ed11c51370821860aa07096a21d507ce69"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#signal-desktop", executablePath = "bin/signal-desktop",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "slack":
  interfaceFingerprint "f3d91e94ebc062a136f339820d2371abf8b321601f7aa79b747148a42e08bdf3"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#slack", executablePath = "bin/slack",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "spotify":
  interfaceFingerprint "4092e02c0eef9ff3e2d506a17a48124a2f41c7fba1b02f47283fc086099c40ca"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#spotify", executablePath = "bin/spotify",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "sqlitebrowser":
  interfaceFingerprint "86c9f9c4142dc958a3b6a7399f21f344e21bff13f9bf7ff91b83191804278f09"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#sqlitebrowser", executablePath = "bin/sqlitebrowser",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "sshfs":
  interfaceFingerprint "23407fcc908fcf98b4b6b77bdb18d1a7f9ed0e114ded0ff364a061e9ffe06ed4"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#sshfs", executablePath = "bin/sshfs",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "starship":
  interfaceFingerprint "62936ddd768d36120221a4540ba858ce4b22eae9909fb647ddd211e17c3e8e93"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#starship", executablePath = "bin/starship",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "steam":
  interfaceFingerprint "141ad236a649ce9f1806d3b1d608826d3a97210f3719042233d77e33dde5cfbf"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#steam", executablePath = "bin/steam",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "swaylock":
  interfaceFingerprint "2125c8a674ea6e6176df31ded22f817294fdaefb353f71cf15db1c84f859bd13"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#swaylock", executablePath = "bin/swaylock",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "swaynotificationcenter":
  interfaceFingerprint "f804026f8fc01adc76e3162e88e7b5993fdee97ae0e630f99f0406b83fe7a9f4"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#swaynotificationcenter", executablePath = "bin/swaync",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "telegram":
  interfaceFingerprint "f6a46eda0a193ca94573c51a8d8c7007ac4c2254cea8fa73b0291c8ba69385d6"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#telegram-desktop", executablePath = "bin/Telegram",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "thunar":
  interfaceFingerprint "ecb66cb5271729ecf430fde748244cba8ea187d25c6f32c521ee5f0142de7b55"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#xfce.thunar", executablePath = "bin/thunar",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "thunderbird":
  interfaceFingerprint "a1f2866c113545a59e655f8ea13d4a07167fe1bcfa4bea4bad9cd41b8603ddc8"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#thunderbird", executablePath = "bin/thunderbird",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "tigervnc":
  interfaceFingerprint "80bd1626dbd9019436b4bdecb43fcf078d4120afa30c754bdb6e24a3c366f2b9"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#tigervnc", executablePath = "bin/vncviewer",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "tilix":
  interfaceFingerprint "dd0d7403475b444737afc7ca6798ea79e4f875106e70225ebe6f884886cbcff4"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#tilix", executablePath = "bin/tilix",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "tmux":
  interfaceFingerprint "c8dfaa0a3482f37ef0bedfb20e17954a18167723ea663ef67f77ab2c137eb504"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#tmux", executablePath = "bin/tmux",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "tmuxinator":
  interfaceFingerprint "6e399e0a9cca47f7480db909303c1f2ec9664e02e8ab62c039fa9a4a5e914532"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#tmuxinator", executablePath = "bin/tmuxinator",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "tor":
  interfaceFingerprint "d94c248925c674368f4897ab357c8bdde32c7d6985bcd42f9d6aa5ecbf7890f4"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#tor", executablePath = "bin/tor",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "trace-cmd":
  interfaceFingerprint "8934cf251f38e5a1a5c2c39455aba95012777bdc7f847e8034a7a631b96d5b61"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#trace-cmd", executablePath = "bin/trace-cmd",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "transmission":
  interfaceFingerprint "8fa5143c5779d93d2b78feed083fe6b2fa8f287599f0b43cde24a26213e0333b"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#transmission_4-gtk", executablePath = "bin/transmission-gtk",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "tree-sitter":
  interfaceFingerprint "615a1cf7519f1779f345957e62b58621bd89d931f5877010f49293815d977f11"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#tree-sitter", executablePath = "bin/tree-sitter",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "util-linux":
  interfaceFingerprint "53475a740ad58ef69d753bf4452f28a8bc7ff28eef58a34267ecbbee8fd07595"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#util-linux", executablePath = "bin/lsblk",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "valgrind":
  interfaceFingerprint "3e55baca59567992abc1abe2f2fd0b9e4d726eb413a4a3823e778b17ac682e2d"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#valgrind", executablePath = "bin/valgrind",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "viber":
  interfaceFingerprint "b0b894c110dd97e74be2fe0455c523a0c7151308dc53ac9cee507332d6e7af7c"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#viber", executablePath = "bin/viber",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "vim":
  interfaceFingerprint "7362e078056bf15ee4121bdb23843795cdbdd18e33e2c791f59e93f28bd23bf8"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#vim", executablePath = "bin/vim",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "vlc":
  interfaceFingerprint "1b4114ca2be7fbfc49ccb469b75d38a96b4cf661652e0ff79857ba93726d9f8b"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#vlc", executablePath = "bin/vlc",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "vscode":
  interfaceFingerprint "8f2b44e1313bf75e9e61a1ab61988aaf83f800d4b8f01abf79b8286c87468faa"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#vscode", executablePath = "bin/code",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "waybar":
  interfaceFingerprint "910e31ef98b6c3730890c5ff535ec70dc10cd9b1df75e4fb492040f0a80e1ca4"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#waybar", executablePath = "bin/waybar",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "wev":
  interfaceFingerprint "061b77429dfc2163804116c29b699bbf73996eb975be1b8e50e3440ab45d2a24"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#wev", executablePath = "bin/wev",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "wget":
  interfaceFingerprint "7fdeaf80f4c444945de5b310f95ac260b620e3634b89392d30a2c629664451cb"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#wget", executablePath = "bin/wget",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "wireshark":
  interfaceFingerprint "ec45a6aaa94e644aeef43ba7ed5ce54060bf5f3e51826812682e77d8b228e090"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#wireshark-qt", executablePath = "bin/wireshark",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "wofi":
  interfaceFingerprint "ff8ae61b873566cf83a88827f50142113bbb081e4d279a445e325dd608999def"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#wofi", executablePath = "bin/wofi",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "xclip":
  interfaceFingerprint "8e57ea5d4ce501a7deadf3660f274d9c3aebdd03b004c9e2333df980a8715df9"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#xclip", executablePath = "bin/xclip",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "xdg-desktop-portal":
  interfaceFingerprint "0bc6d9e7817d70b7f5cce9e1dfc9148977a58a05bd04e7e2cc61131af2c50dea"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#xdg-desktop-portal", executablePath = "libexec/xdg-desktop-portal",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "xdg-desktop-portal-hyprland":
  interfaceFingerprint "3153cbf54e854e1ba34932ede9992e2374214831d3bc23e156c4a877da30ab50"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#xdg-desktop-portal-hyprland", executablePath = "bin/hyprland-share-picker",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "xwayland":
  interfaceFingerprint "2b3e50459ccb78ca92bf5045662333a76fe9198e13139f487724bc4426d744b3"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#xwayland", executablePath = "bin/Xwayland",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "yq":
  interfaceFingerprint "9f189692d58e8cdaf3bca371b225b82c7caadac2a2a90b3354e712676ecbdf1d"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#yq", executablePath = "bin/yq",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "zed-editor":
  interfaceFingerprint "fe1c7135985e1ce82e9da6eae116f39946fae82721bb8c12785fb2fdbc306dc6"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#zed-editor", executablePath = "bin/zeditor",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "zellij":
  interfaceFingerprint "eb03589144bc6e25366a9b9518a7e2ba40e8e603def4339e416fede0c23543e9"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#zellij", executablePath = "bin/zellij",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "zoom":
  interfaceFingerprint "e51b411eaec1ff27ed0f6954a95fbb2b26c1fb39c05ca733738df20269cbdc2f"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#zoom-us", executablePath = "bin/zoom",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "zoxide":
  interfaceFingerprint "fd44d12de297cef2c7f9f4c143953695f9ec0b443a366fcac82126803dd04a7d"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#zoxide", executablePath = "bin/zoxide",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "zplug":
  interfaceFingerprint "ba55e3d345187e20475eb7b58c5d983f0bc731fda2544c6d33ad82305482b69c"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#zplug", executablePath = "share/zplug/init.zsh",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

provisioningFor "zsh":
  interfaceFingerprint "7a9d06c49c5b0ac019033f0f784f81ef29f0c83c9b73982e12e2e6059503b59d"
  contributor "github:metacraft-labs/reprobuild-nix-packages"
  nixPackage "nixpkgs#zsh", executablePath = "bin/zsh",
    nixpkgsRev = CanonicalNixpkgsRev,
    nixpkgsNarHash = CanonicalNixpkgsNarHash

package reprobuildNixPackages:
  devEnv:
    task "test",
      command = "nim c -r --nimcache:build/nimcache-nix-catalog tests/test_nix_catalog.nim",
      description = "Validate the Nix contribution catalog"
