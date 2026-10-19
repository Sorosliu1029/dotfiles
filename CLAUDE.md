# CLAUDE.md

Personal dotfiles for macOS (primary) and an Ubuntu box, managed with GNU Stow. Philosophy: https://dotfiles.github.io/

## Layout: one top-level dir = one stow package

Each package dir mirrors `$HOME`. `stow <pkg>` (run from this repo, target defaults to the parent dir `~`) symlinks its contents into `~`:

- `zsh/.zshrc` → `~/.zshrc`
- `nvim/.config/nvim/` → `~/.config/nvim` (XDG apps nest under `.config/<app>/`)

Stow **folds** trees: `~/.config/nvim` is a single symlink to the repo dir, so anything an app writes there lands in the repo. Per-package `.gitignore` files (e.g. `btop/`, `nvim/` ignore `lazy-lock.json`, logs) exist for this reason; add one when a new app writes runtime state into its config dir.

`stow.sh` is the source of truth for which packages are stowed on which OS — read it rather than guessing. When adding a package, add it to the right list(s) there.

## Not stow packages

Some dirs hold files that are imported/applied by hand, never stowed: `homebrew/` (Brewfiles + install scripts), `apt/`, `iterm2/`, `raycast/`, `eudic/`, `ublock/`, `vimium/`, `wifi-location-changer/` (own installer + README), `systemd/` (Linux unit files, copied into `/etc/systemd` or `~/.config/systemd`), `machine-spec/`, `pip/`, `asdf/`. `setup.sh` bootstraps a machine (Homebrew, Brewfile, both `stow.sh`, oh-my-zsh, tpm); keep it idempotent: each step checks before acting.

## Ignore rules

- `stow/.stow-global-ignore` (itself stowed to `~`) — patterns stow skips in every package (`LICENSE`, `.gitignore`, `.DS_Store`, ...).
- `<pkg>/.stow-local-ignore` — per-package; **replaces** the global list for that package, so it must repeat any global pattern still needed. E.g. `zsh/` keeps `linux.zsh` out of `~` (`.zshrc` resolves its own symlink and sources `<os>.zsh` from the repo), `conda/` keeps `jupyter.env.yml` out.

## Secrets live elsewhere

Machine-specific and secret config lives in a separate private repo at `~/.dotfiles_private` (own `stow.sh`; provides `~/.gitconfig_local`, `~/.npmrc`, `~/.pypirc`, ssh, etc.). `git/.gitconfig` pulls identity via `[include] path = ~/.gitconfig_local`. Both repos stow a `gh` package into `~/.config/gh` (`config.yml` here, `hosts.yml` there), so `gh` is stowed with `--no-folding` in each and must stay that way. Keep tokens, hostnames, and personal identifiers in that private repo; this one is public.

## Cross-platform

Shared files branch on OS at runtime (`uname -s` → `$machine` = `Mac`/`Linux`, the same pattern in `stow.sh`, `setup.sh`, `zsh/.zshrc`). Edits to shared configs must keep the Linux path working.

## Verifying a change

- Preview before linking: `stow -nvv --dotfiles <pkg>` (dry run; reports conflicts with existing real files).
- Edits to an already-stowed file take effect immediately via the symlink; no restow needed. Restow (`stow -R <pkg>`) only after adding/removing/renaming files.
