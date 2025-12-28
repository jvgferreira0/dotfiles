#!/usr/bin/env bash
# ===============================================
# Baal Framework - Helper Functions Library
# ===============================================

# Colors for output
export BAAL_COLOR_RESET="\033[0m"
export BAAL_COLOR_RED="\033[0;31m"
export BAAL_COLOR_GREEN="\033[0;32m"
export BAAL_COLOR_YELLOW="\033[0;33m"
export BAAL_COLOR_BLUE="\033[0;34m"
export BAAL_COLOR_PURPLE="\033[0;35m"
export BAAL_COLOR_CYAN="\033[0;36m"

# Framework paths
export BAAL_HOME="${BAAL_HOME:-$HOME/.config/baal}"
export BAAL_THEMES_DIR="$BAAL_HOME/themes"
export BAAL_DEFAULTS_DIR="$BAAL_HOME/defaults"
export BAAL_PROFILES_DIR="$BAAL_HOME/profiles"
export BAAL_BIN_DIR="$BAAL_HOME/bin"

# Logging functions
baal_log() {
    echo -e "${BAAL_COLOR_BLUE}[Baal]${BAAL_COLOR_RESET} $*"
}

baal_success() {
    echo -e "${BAAL_COLOR_GREEN}✓${BAAL_COLOR_RESET} $*"
}

baal_error() {
    echo -e "${BAAL_COLOR_RED}✗${BAAL_COLOR_RESET} $*" >&2
}

baal_warn() {
    echo -e "${BAAL_COLOR_YELLOW}⚠${BAAL_COLOR_RESET} $*"
}

baal_info() {
    echo -e "${BAAL_COLOR_CYAN}ℹ${BAAL_COLOR_RESET} $*"
}

# Check if command exists
baal_has_command() {
    command -v "$1" &> /dev/null
}

# Source file if it exists
baal_source() {
    local file="$1"
    if [ -f "$file" ]; then
        # shellcheck source=/dev/null
        source "$file"
        return 0
    fi
    return 1
}

# Create symlink with backup
baal_link() {
    local source="$1"
    local target="$2"

    if [ -L "$target" ]; then
        rm "$target"
    elif [ -e "$target" ]; then
        mv "$target" "${target}.baal-backup"
        baal_warn "Backed up existing file: ${target}.baal-backup"
    fi

    ln -sf "$source" "$target"
    baal_success "Linked: $target -> $source"
}

# Get current theme
baal_get_theme() {
    if [ -L "$BAAL_HOME/current-theme" ]; then
        basename "$(readlink "$BAAL_HOME/current-theme")"
    else
        echo "catppuccin-mocha"  # Default theme
    fi
}

# Set theme
baal_set_theme() {
    local theme="$1"
    local theme_dir="$BAAL_THEMES_DIR/$theme"

    if [ ! -d "$theme_dir" ]; then
        baal_error "Theme '$theme' not found"
        return 1
    fi

    rm -f "$BAAL_HOME/current-theme"
    ln -sf "$theme_dir" "$BAAL_HOME/current-theme"
    baal_success "Theme set to: $theme"
}

# Load configuration module
baal_load() {
    local module="$1"
    local file="$BAAL_DEFAULTS_DIR/$module"

    if baal_source "$file"; then
        return 0
    else
        baal_warn "Module not found: $module"
        return 1
    fi
}

# Functions are automatically available in zsh
# No need to export them like in bash
