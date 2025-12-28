# Dotfiles Configuration

XDG-compliant dotfiles configuration for Arch Linux.

## Structure

This repository follows the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html):

```
~/.config/                    # XDG_CONFIG_HOME (this repo)
├── baal/                     # Dotfiles management framework
│   ├── bin/                  # Baal CLI tools
│   ├── defaults/             # Default configurations
│   │   └── zsh/              # Modular ZSH config
│   └── themes/               # Color themes
├── bash/bashrc               # Bash configuration
├── zsh/
│   ├── zshrc                 # ZSH configuration
│   └── zprofile              # ZSH profile
├── git/
│   ├── config                # Git configuration
│   └── ignore                # Global gitignore
├── tmux/tmux.conf            # Tmux configuration
├── nvim/                     # Neovim configuration
├── hypr/                     # Hyprland window manager
├── alacritty/                # Alacritty terminal
└── ...                       # Other application configs
```

## Home Directory Symlinks

The following symlinks in `~/` point to configs in `~/.config/`:

- `~/.bashrc` → `~/.config/bash/bashrc`
- `~/.gitconfig` → `~/.config/git/config`
- `~/.tmux.conf` → `~/.config/tmux/tmux.conf`
- `~/.zprofile` → `~/.config/zsh/zprofile`
- `~/.zshrc` → `~/.config/baal/defaults/zsh/rc` (managed by baal)

## Baal Framework

This configuration uses [Baal](./baal/) for modular dotfiles management.

### Usage

```bash
# Add baal to PATH (add to your shell rc)
export PATH="$HOME/.config/baal/bin:$PATH"

# Show status
baal status

# List available themes
baal themes

# Switch theme
baal theme <theme-name>
```

## Installation

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/.config
   ```

2. Create symlinks in home directory:
   ```bash
   ln -s ~/.config/bash/bashrc ~/.bashrc
   ln -s ~/.config/git/config ~/.gitconfig
   ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf
   ln -s ~/.config/zsh/zprofile ~/.zprofile
   ln -s ~/.config/baal/defaults/zsh/rc ~/.zshrc
   ```

3. Add baal to PATH in your shell configuration

## Backup

A backup of the previous configuration structure was created at:
`~/config-backup-YYYYMMDD/`

## License

MIT

## Author

JVG Ferreira
