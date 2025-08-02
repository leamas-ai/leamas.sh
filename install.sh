#!/bin/bash

set -euo pipefail

GITHUB_REPO="leamas-ai/leamas"
GITHUB_BRANCH="main"
LEAMAS_SCRIPT_URL="https://raw.githubusercontent.com/${GITHUB_REPO}/${GITHUB_BRANCH}/leamas"
INSTALL_DIR="$HOME/leamas"

log() {
    echo "==> $1" >&2
}

error() {
    echo "Error: $1" >&2
    exit 1
}

check_dependencies() {
    local deps=("curl")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            error "Required dependency '$dep' not found. Please install it first."
        fi
    done
}

install_leamas() {
    local temp_file
    temp_file=$(mktemp)
    
    log "Downloading leamas from GitHub..."
    if ! curl -sSL -o "$temp_file" "$LEAMAS_SCRIPT_URL"; then
        error "Failed to download leamas from $LEAMAS_SCRIPT_URL"
    fi
    
    log "Installing leamas to $INSTALL_DIR..."
    cp "$temp_file" "$INSTALL_DIR/leamas"
    chmod +x "$INSTALL_DIR/leamas"
    
    rm -f "$temp_file"
    
    log "leamas installed successfully!"
    echo
    log "To use leamas from anywhere, add this to your shell profile:"
    echo "    export PATH=\"\$HOME:\$PATH\""
    echo
    log "For bash, add to ~/.bashrc or ~/.bash_profile:"
    echo "    echo 'export PATH=\"\$HOME:\$PATH\"' >> ~/.bashrc"
    echo
    log "For zsh, add to ~/.zshrc:"
    echo "    echo 'export PATH=\"\$HOME:\$PATH\"' >> ~/.zshrc"
    echo
    log "For fish, run:"
    echo "    set -U fish_user_paths \$HOME \$fish_user_paths"
    echo
    log "After updating your shell profile, restart your terminal or run:"
    echo "    source ~/.bashrc  # or ~/.zshrc"
    echo
    log "Then try: leamas --help"
    echo
    log "To install agent kits, use:"
    echo "    leamas agent@<kit-name>"
    echo
    log "Available kits are hosted at:"
    echo "    https://leamas.sh/kits"
}

main() {
    if [[ -f "$INSTALL_DIR/leamas" ]]; then
        log "leamas is already installed at $INSTALL_DIR/leamas"
        log "Run 'leamas --version' to check the version."
        log "To update, remove the existing installation first:"
        echo "    rm $INSTALL_DIR/leamas"
        exit 0
    fi
    
    check_dependencies
    install_leamas
}

main "$@"