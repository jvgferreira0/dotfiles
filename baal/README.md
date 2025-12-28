# Baal - Dotfiles Framework

A modular, theme-able dotfiles management framework for Arch Linux.

## Features

- **Modular Configuration**: ZSH config split into logical modules (options, history, aliases, functions, etc.)
- **Theme Support**: Easy theme switching for terminal colors and aesthetics
- **FZF Integration**: Beautiful fuzzy finder with Catppuccin Mocha theme
- **Modern CLI Tools**: Built-in support for bat, eza, zoxide, starship
- **Simple Management**: Easy-to-use CLI for installation and theme switching

## Quick Start

### Installation

```bash
# Clone the repository (or use existing ~/config repo)
cd ~/config/baal

# Add Baal to PATH
export PATH="$HOME/config/baal/bin:$PATH"

# Run installation
baal install
```

### Usage

```bash
# Show status
baal status

# List available themes
baal themes

# Switch theme
baal theme nord

# Update framework
baal update
```

## Structure

```
baal/
├── bin/               # Utility scripts
│   └── baal          # Main CLI tool
├── lib/               # Helper functions
│   └── helpers.sh
├── themes/            # Color themes
│   ├── catppuccin-mocha/
│   ├── nord/
│   └── gruvbox/
├── defaults/          # Default configurations
│   ├── zsh/          # ZSH configuration modules
│   │   ├── rc        # Main loader
│   │   ├── options   # ZSH options
│   │   ├── history   # History configuration
│   │   ├── completion # Completion system
│   │   ├── keybindings # Custom keybindings
│   │   ├── aliases   # Aliases
│   │   ├── functions # Custom functions
│   │   ├── fzf       # FZF configuration
│   │   ├── plugins   # Plugin loading
│   │   └── prompt    # Prompt configuration
│   └── alacritty/    # Alacritty config
│       └── base.toml
└── current-theme -> themes/catppuccin-mocha
```

## Themes

Themes can customize:
- Terminal colors (Alacritty)
- FZF colors
- ZSH prompt
- Any other theme-specific settings

### Available Themes

- **Catppuccin Mocha** (default) - Warm, modern color scheme
- **Nord** - Arctic, north-bluish color palette
- **Gruvbox** - Retro groove color scheme

### Creating a Theme

Create a new directory in `themes/` with these files:

```
themes/my-theme/
├── theme.conf          # Theme metadata
├── zshrc              # ZSH customizations
└── alacritty.toml     # Alacritty colors
```

## Configuration Modules

### ZSH Modules

Each module handles a specific aspect of ZSH configuration:

- **options**: Shell behavior and options
- **history**: History size, options, and behavior
- **completion**: Completion system and styling
- **keybindings**: Custom key bindings
- **aliases**: Command aliases
- **functions**: Custom shell functions
- **fzf**: FZF configuration and keybindings
- **plugins**: External plugin loading
- **prompt**: Prompt configuration (Starship or simple)

## Requirements

### Essential

- zsh
- git

### Recommended

- starship (modern prompt)
- fzf (fuzzy finder)
- bat (better cat)
- eza (better ls)
- zoxide (smart cd)
- ripgrep (fast grep)
- fd (fast find)

### Optional

- zsh-syntax-highlighting
- zsh-autosuggestions
- chafa (image previews in terminal)
- pdftotext (PDF previews in FZF)

## Installation of Dependencies

```bash
# Arch Linux
sudo pacman -S zsh starship fzf bat eza zoxide ripgrep fd \
               zsh-syntax-highlighting zsh-autosuggestions
```

## License

MIT

## Author

JVG Ferreira
