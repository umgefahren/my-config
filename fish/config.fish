if status is-interactive
    # Commands to run in interactive sessions can go here
end

if status --is-login
        set -gx PNPM_HOME /Users/hannesfurmans/Library/pnpm
        set -gx GOROOT (go env GOROOT)
        fish_add_path $PNPM_HOME
        fish_add_path $GOROOT/bin
        fish_add_path (go env GOPATH)/bin
        fish_add_path ~/.cargo/bin/
end

alias edit_fish_config "nvim ~/.config/fish/config.fish"


starship init fish | source
zoxide init fish | source
