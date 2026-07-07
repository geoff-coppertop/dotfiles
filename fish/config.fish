function fish_greeting
    fastfetch
end

function ls
    eza --icons=always $argv
end

function ll
    ls -lah $argv
end

function lt
    ll --tree --level=3 $argv
end

alias cat 'bat'
alias l 'ls -l'
alias .. 'cd ..'
alias ... 'cd ../..'

starship init fish | source
zoxide init fish | source

# Devcontainers: rootless Podman needs --userns=keep-id so bind-mounted
# workspace files keep the host UID (Docker rejects that flag). devcontainer
# configs read this via ${localEnv:DEVCONTAINER_USERNS:host}, so it only
# matters on hosts whose container engine is Podman — including when `docker`
# is really the podman-docker shim. Inside containers podman is absent and
# this no-ops.
if not set -q DEVCONTAINER_USERNS; and type -q podman
    if not type -q docker; or docker --version 2>/dev/null | string match -qi '*podman*'
        set -gx DEVCONTAINER_USERNS keep-id
    end
end

set -gx FZF_DEFAULT_COMMAND 'fd --type f'
set -gx FZF_CTRL_T_COMMAND 'fd --type f'
set -gx FZF_ALT_C_COMMAND 'fd --type d'

# fzf key bindings (Ctrl+R history, Ctrl+T file, Alt+C cd)
if test -f /usr/share/doc/fzf/examples/key-bindings.fish
    source /usr/share/doc/fzf/examples/key-bindings.fish
end
