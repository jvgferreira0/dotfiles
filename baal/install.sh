#!/usr/bin/env bash
# ===============================================
# Baal Framework Installer
# ===============================================

set -e

BAAL_REPO="https://github.com/jvgferreira0/config.git"
BAAL_DIR="$HOME/.config/baal"

echo "╔═══════════════════════════════════════════╗"
echo "║                                           ║"
echo "║            Baal Framework                 ║"
echo "║        Dotfiles Management System         ║"
echo "║                                           ║"
echo "╚═══════════════════════════════════════════╝"
echo ""

# Check if already installed
if [ -d "$BAAL_DIR" ]; then
    echo "✓ Baal is already installed at $BAAL_DIR"
    echo ""
    echo "To reinstall, remove the directory first:"
    echo "  rm -rf $BAAL_DIR"
    exit 0
fi

# Clone or copy
if [ -d "$(dirname "$0")/baal" ]; then
    echo "→ Installing from local copy..."
    cp -r "$(dirname "$0")" "$BAAL_DIR"
else
    echo "→ Cloning from repository..."
    git clone "$BAAL_REPO" "$BAAL_DIR"
fi

# Add to PATH
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "baal/bin" "$HOME/.zshrc"; then
        echo "" >> "$HOME/.zshrc"
        echo "# Baal Framework" >> "$HOME/.zshrc"
        echo "export PATH=\"\$HOME/.config/baal/bin:\$PATH\"" >> "$HOME/.zshrc"
    fi
fi

echo ""
echo "✓ Baal framework installed successfully!"
echo ""
echo "Next steps:"
echo "  1. Add Baal to your PATH (if not already done):"
echo "     export PATH=\"\$HOME/.config/baal/bin:\$PATH\""
echo ""
echo "  2. Run the installer:"
echo "     baal install"
echo ""
echo "  3. Restart your terminal or run:"
echo "     source ~/.zshrc"
echo ""
