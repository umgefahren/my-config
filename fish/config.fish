if status is-interactive
        fish_vi_key_bindings
        starship init fish | source
        zoxide init fish | source
end

if status --is-login
        set -gx PNPM_HOME /Users/hannesfurmans/Library/pnpm
        set -gx GOROOT (go env GOROOT)
        fish_add_path $PNPM_HOME
        fish_add_path $GOROOT/bin
        fish_add_path (go env GOPATH)/bin
        fish_add_path ~/.cargo/bin/
        set -gx GPG_TTY (tty)
        set -gx LANG "en_US.UTF-8"
        set -gx LC_CTYPE "en_US.UTF-8"
        set -gx GO111MODULE on
        set -gx FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix"
end

alias edit_fish_config "nvim ~/.config/fish/config.fish"
alias fzf "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

function cdd -d "Create a directory and set CWD"
        command mkdir $argv
        if test $status = 0
                switch $argv[(count $argv)]
                        case '-*'

                        case '*'
                                cd $argv[(count $argv)]
                                return
                end
        end
end

function fish_greeting
        set choice (random 1 2 3)
        switch $choice
        case 1
                fish_logo blue cyan green
                echo ""
                fortune
        case 2
                fortune /usr/local/Cellar/fortune/9708/share/games/fortunes/ascii-art
        case 3
                fastfetch
        end
end

function resource
        source $HOME/.config/fish/config.fish
end


