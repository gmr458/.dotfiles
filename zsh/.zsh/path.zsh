path_append() {
  case ":$PATH:" in
    *:"$1":*) ;;
    *) export PATH="$PATH:$1" ;;
  esac
}

path_append "$HOME/.local/bin"
path_append "$HOME/.cargo/bin"
path_append "$(go env GOPATH)/bin"

if [[ ! -f /etc/NIXOS ]]; then
  path_append "/usr/local/flutter/bin"
  path_append "$DENO_INSTALL/bin"
  path_append "$BUN_INSTALL/bin"
  path_append "/usr/local/odin"
  path_append "/usr/local/c3"
  path_append "/usr/local/zig"
  path_append "/opt/gradle/gradle-9.1.0/bin"
  path_append "$ANDROID_HOME/emulator"
  path_append "$ANDROID_HOME/platform-tools"
  path_append "$PNPM_HOME/bin"
fi
