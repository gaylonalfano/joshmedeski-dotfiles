# PATH additions, toolchain config, and source commands

# Bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Cargo
fish_add_path $HOME/.cargo/bin

# Ghostty
fish_add_path /Applications/Ghostty.app/Contents/MacOS

# Go
set -x GOROOT /opt/homebrew/opt/go/libexec
set -x GOPATH $HOME/go

# Java
fish_add_path /opt/homebrew/opt/openjdk/bin

# jg
fish_add_path /Users/joshmedeski/c/jg/main

# Obsidian
fish_add_path "/Applications/Obsidian.app/Contents/MacOS"

# OrbStack
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# pnpm
set -gx PNPM_HOME /Users/joshmedeski/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# Rust
source "$HOME/.cargo/env.fish"

# tmux plugin manager
set -Ux TMUX_PLUGIN_MANAGER_PATH "$HOME/.config/tmux/plugins"

# uv / build toolchain
set -x CPPFLAGS "-I/opt/homebrew/include"
set -x LDFLAGS "-L/opt/homebrew/lib"
source "$HOME/.local/bin/env.fish"
