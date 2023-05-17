if status is-interactive
    set -gx PNPM_HOME $HOME/.local/share/pnpm
    fish_add_path /home/linuxbrew/.linuxbrew/bin $HOME/.krew/bin $HOME/.cargo/bin $HOME/.local/bin $HOME/.bun/bin $PNPM_HOME /opt/homebrew/bin
    set -Ux BUN_INSTALL $HOME/.bun
    set _ZO_ECHO 1
    set -gx EDITOR micro
    procs --gen-completion-out fish | source
    starship init fish | source
    zoxide init fish | source
    abbr cat bat -p
    abbr fc micro ~/.config/fish/config.fish
    abbr ll lsd -la --group-directories-first
    abbr sc micro ~/.ssh/config
    abbr rm-ids "fd -H '.*:Zone.Identifier' -x rm"
    abbr start explorer.exe
    abbr maip http -pb ifconfig.me
    abbr top btm
    abbr ps procs
    abbr cd z
    abbr tree br
    abbr grep rg
    abbr find fd
    abbr df duf
    abbr du dua
    abbr diff delta
    abbr fd fd -H
    abbr gr "cd (git rev-parse --show-toplevel)"
    
    # I couldn't find a way to permanently set ulimit in WSL. but this works
    ulimit -Sn 65535
end

function fish_user_key_bindings
    # ctrl + backspace to delete previous word
    bind \cH backward-kill-path-component
    # ctrl + delete to to delete forward word
    bind \[3\;5~ kill-word
end

# https://stackoverflow.com/questions/71502585/how-to-open-a-tab-pane-in-the-same-directory-in-windows-terminal-with-fish-shell/71502586#71502586
function storePathForWindowsTerminal --on-variable PWD
    if test -n "$WT_SESSION"
      printf "\e]9;9;%s\e\\" (wslpath -w "$PWD")
    end
end

function killPort
    set pid (procs $argv[1] | rg "^ (\d+)" -or '$1')
    kill -9 $pid
    echo killed process $pid
end
