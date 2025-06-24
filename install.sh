#!/usr/bin/env bash

# ry installation script

set -e

# Default installation prefix
PREFIX="${PREFIX:-$HOME/.local}"
BASH_COMPLETIONS_DIR="${BASH_COMPLETIONS_DIR:-$PREFIX/share/bash-completion/completions}"
ZSH_COMPLETIONS_DIR="${ZSH_COMPLETIONS_DIR:-$PREFIX/share/zsh/site-functions}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[ry installer]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[ry installer]${NC} $1"
}

error() {
    echo -e "${RED}[ry installer]${NC} $1" >&2
    exit 1
}

# Check if we're in the right directory
if [[ ! -f "bin/ry" ]]; then
    error "bin/ry not found. Please run this script from the ry repository root."
fi

# Create directories
log "Creating directories..."
mkdir -p "$PREFIX/bin"
mkdir -p "$BASH_COMPLETIONS_DIR"
mkdir -p "$ZSH_COMPLETIONS_DIR"

# Install main script
log "Installing ry to $PREFIX/bin/ry"
cp "bin/ry" "$PREFIX/bin/ry"
chmod +x "$PREFIX/bin/ry"

# Install completions
log "Installing bash completion to $BASH_COMPLETIONS_DIR/ry"
cp "share/ry.bash_completion" "$BASH_COMPLETIONS_DIR/ry"

log "Installing zsh completion to $ZSH_COMPLETIONS_DIR/_ry"
cp "share/ry.zsh_completion" "$ZSH_COMPLETIONS_DIR/_ry"

log "Installation complete!"
echo
echo "Next steps:"
echo "1. Make sure $PREFIX/bin is in your PATH:"
echo "   export PATH=\"$PREFIX/bin:\$PATH\""
echo
echo "2. Add ry setup to your shell configuration:"
echo "   eval \"\$(ry setup)\""
echo
echo "3. For bash completion, make sure bash-completion is installed"
echo "4. For zsh completion, make sure $ZSH_COMPLETIONS_DIR is in your fpath"
echo
echo "You may need to restart your shell or source your configuration file."
