#!/usr/bin/env bash

# ry installation script

set -e

# Default installation prefix
PREFIX="${PREFIX:-$HOME/.local}"
if command -v zsh &>/dev/null; then
  PROFILE="${PROFILE:-$HOME/.zprofile}"
else
  PROFILE="${PROFILE:-$HOME/.bash_profile}"
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[ry installer]${NC} $1"
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

# Install main script
log "Installing ry to $PREFIX/bin/ry"
cp "bin/ry" "$PREFIX/bin/ry"
chmod +x "$PREFIX/bin/ry"

# Update profile
ry_eval='eval "$(ry setup)"'
if ! grep -Fq "$ry_eval" "$PROFILE" 2>/dev/null; then
  echo "$ry_eval" | tee -a "$PROFILE"
fi

path_export="export PATH=\"\$HOME/.local/bin:\$PATH\""
if ! grep -Fq "$path_export" "$PROFILE" 2>/dev/null; then
  echo "$path_export" | tee -a "$PROFILE"
fi

log "Installation complete!"
