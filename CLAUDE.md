# CLAUDE.md

Personal dotfiles for configuring a terminal-based dev environment. Primary target is **macOS with iTerm2**; should also work on **Linux** and **GitHub Codespaces**. Lives at `~/.dotfiles` (hard requirement — `zsh/zshrc` errors out otherwise, except inside Codespaces where it resolves to `/workspaces/.codespaces/.persistedshare/dotfiles`).

## Setup / install

```bash
git clone <repo> ~/.dotfiles && cd ~/.dotfiles && ./install
```

`./install` bootstraps the `.dotbot` submodule and runs [dotbot](https://github.com/anishathalye/dotbot) with `install.conf.yaml`. The install flow:
1. Symlinks config files into `$HOME` / `~/.config` (the `link:` block).
2. `git submodule update --init --recursive` — pulls `.dotbot`, `.zinit`, `tmux/tpm`.
3. Finds every `install.sh`, chmods it, and runs it (one-time per-app setup).

Re-running `./install` is safe and idempotent (links use `force`/`relink`).

## Repo structure

Each application has its own top-level folder holding its config plus optional zsh glue:

- `zsh/` — `zshrc` (the entry point, symlinked to `~/.zshrc`), `config.zsh`, `completions.zsh`, `secrets.zsh` (gitignored), `functions/` (autoloaded).
- `nvim/` — `vimrc` → `~/.config/nvim/init.vim`, `ideavimrc` → `~/.ideavimrc`, `configs/` split per editor (`base`, `neovim`, `idea`, `vscode`).
- `git/`, `tmux/`, `docker/`, `system/`, `cf/`, `iterm2/`, `via/` — per-app config.
- `bin/` — scripts on `$PATH`.
- `.dotbot/`, `.zinit/`, `tmux/tpm/` — git submodules; do not edit directly.

### Two conventions zsh relies on

- **`aliases.zsh`** — any `*/aliases.zsh` file is auto-sourced on shell startup via a glob in `zshrc` (`for file in $DOTFILES/**/aliases.zsh`). Add a new app's aliases by dropping an `aliases.zsh` in its folder; no wiring needed.
- **`install.sh`** — any `install.sh` is auto-run by the installer for one-time machine setup. Keep these OS-guarded (see `iterm2/install.sh`, which checks `uname -s` / `Darwin`).

New symlinks must be added to the `link:` block in `install.conf.yaml`.

## Shell details

- Plugin manager is **zinit** (`.zinit` submodule), sourced from `zshrc`. Plugins: `zsh-autosuggestions`, `fast-syntax-highlighting`, `geometry` prompt, `zsh-256color`.
- `zshrc` load order matters: env vars → zinit → `config.zsh` → `completions.zsh` → `secrets.zsh` (if present) → aliases → plugins → nvm → **sdkman must stay last**.
- Secrets live in `zsh/secrets.zsh` (gitignored) — never commit real secrets.
- Several paths are SAP-specific (`JAVA_HOME` → sapmachine, `git/.gitconfig-sap`, `cf/` for Cloud Foundry). Keep machine/employer-specific bits out of the generic configs.

## Conventions

- Keep changes cross-platform where feasible; guard macOS-only behavior with `uname -s` checks (`Darwin`).
- Don't edit submodule contents (`.dotbot`, `.zinit`, `tmux/tpm`) — update the submodule reference instead.
- Match the existing style of the file you're editing.
