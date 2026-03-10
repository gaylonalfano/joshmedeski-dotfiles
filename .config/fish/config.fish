#
# ███████╗██╗███████╗██╗  ██╗
# ██╔════╝██║██╔════╝██║  ██║
# █████╗  ██║███████╗███████║
# ██╔══╝  ██║╚════██║██╔══██║
# ██║     ██║███████║██║  ██║
# ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
# A smart and user-friendly command line
# https://fishshell.com/
# cSpell:words shellcode pkgx direnv

# brew shellenv cached in conf.d/brew.fish
# Regenerate with: /opt/homebrew/bin/brew shellenv > ~/.config/fish/conf.d/brew.fish

if status --is-interactive
    if not set -q TMUX
        sesh_start
    end
end

command -q starship; and starship init fish | source # https://starship.rs/
command -q zoxide; and zoxide init fish | source # 'ajeetdsouza/zoxide'
command -q fzf; and fzf --fish | source
command -q fnm; and fnm --log-level quiet env --use-on-cd | source # "Schniz/fnm"
command -q direnv; and direnv hook fish | source # https://direnv.net/
command -q fx; and fx --comp fish | source # https://fx.wtf/
set -g direnv_fish_mode eval_on_arrow # trigger direnv at prompt, and on every arrow-based directory change (default)

set -g fish_greeting # disable fish greeting
set -Ux BAT_THEME "Catppuccin Latte" # 'sharkdp/bat' cat clone
set -Ux EDITOR nvim # 'neovim/neovim' text editor
set -Ux FZF_DEFAULT_COMMAND "fd -H -E '.git'"

set -Ux FZF_DEFAULT_OPTS (printf '%s ' \
    '--layout=reverse' \
    '--info=hidden' \
    '--ansi' \
    '--pointer=👉' \
    '--gutter=" "' \
    '--color=current-bg:-1' \
    '--color=current-fg:blue' \
    '--color=gutter:-1' \
    '--color=header-bg:-1' \
    '--color=header-border:cyan' \
    '--color=hl+:yellow' \
    '--color=hl:yellow' \
    '--color=input-border:yellow' \
    '--color=list-border:blue' \
    '--color=pointer:blue' \
    '--color=preview-border:cyan' | string collect)

set -e PAGER nvimpager


# golang - https://golang.google.cn/
set -Ux GOPATH "$HOME/go"
fish_add_path $GOPATH/bin
fish_add_path $HOME/.rustup/toolchains/nightly-aarch64-apple-darwin/bin

fish_add_path $HOME/.config/bin # my custom scripts
fish_add_path $HOME/Library/Python/3.9/bin
fish_add_path $HOME/.local/share/bob/nvim-bin

fish_add_path $HOME/.gdvm/bin/current_godot $HOME/.gdvm/bin


# Mole completions cached in completions/mole.fish
# Regenerate with: mole completion fish > ~/.config/fish/completions/mole.fish
