# dotfiles

My dotfiles for macOS and Ubuntu, managed with [GNU Stow](https://www.gnu.org/software/stow/).
ref: https://dotfiles.github.io/

## New machine

```sh
git clone git@github.com:Sorosliu1029/dotfiles.git ~/.dotfiles
git clone <private repo> ~/.dotfiles_private   # secrets & machine-specific config
~/.dotfiles/setup.sh
```

`setup.sh` installs Homebrew and the Brewfile, runs both repos' `stow.sh`,
then installs oh-my-zsh, its plugins, Rime (macOS), and tpm. It is safe to
re-run; finished steps are skipped.

## Day to day

- Edit files in place; they are symlinked into `~`.
- After adding, removing, or renaming files in a package, re-run `./stow.sh`.
- New package: create `<name>/` mirroring `~`, then add it to `stow.sh`.

Folders not listed in `stow.sh` (`homebrew/`, `iterm2/`, `raycast/`,
`systemd/`, ...) hold exports and scripts that are applied by hand.
