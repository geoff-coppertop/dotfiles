# dotfiles

The single source of truth for the shell/git "look and feel" shared between
[nixos-config](https://github.com/geoff-coppertop/nixos-config) (consumed via
home-manager's `home.file.source`) and
[devcontainer-features](https://github.com/geoff-coppertop/devcontainer-features)'s
`shell-baseline` feature (consumed via a pinned `git clone` + `cp` in
`install.sh`). Plain files, no dotfile manager — neither templating nor
encrypted secrets are needed here.

## What's managed here

- `fish/config.fish` — fish aliases/functions, starship + zoxide `init fish`
  lines, fzf widget commands and key-binding source.
- `git/config` — git aliases, color, commit template path, fetch/merge/
  difftool wiring, pull/rebase defaults.
- `git/commit-template` — commit message template.

## What's deliberately *not* here

Package installation, shell registration (`/etc/shells`), and machine/
identity-specific git settings (`user.name`, `user.email`, `core.editor`,
`core.excludesfile`, `safe.directory`) stay owned by whichever environment
consumes this repo — home-manager for NixOS, plain installs for
devcontainers. This repo only owns shared config *content*, not the
mechanism that installs the underlying tools.

## Consuming this repo

**NixOS / home-manager**: pinned as a flake input (`flake = false`), linked
directly with `home.file.<path>.source = "${dotfiles}/<path>";` — no apply
step, no extra package.

**Devcontainers**: `shell-baseline`'s `install.sh` clones a pinned tag of
this repo and copies the files into place at image build time.

## Versioning

Tagged releases (`v1`, `v2`, ...) are the pin points consumers reference.
Untagged commits on `main` are work in progress.
