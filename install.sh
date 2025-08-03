#!/bin/bash

set -euo pipefail

GITHUB_REPO="leamas-ai/leamas.sh"
GITHUB_BRANCH="main"
LEAMAS_SCRIPT_URL="https://raw.githubusercontent.com/${GITHUB_REPO}/${GITHUB_BRANCH}/leamas"
INSTALL_DIR="$HOME/leamas"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m' # No Color

# Unicode characters
CHECK="✓"
CROSS="✗"
ARROW="→"
DOT="•"
PACKAGE="📦"
DOWNLOAD="⬇"
GLOBE="🌐"
SPARKLE="✨"
ROCKET="🚀"
WARN="⚠️"
INFO="ℹ"
WRENCH="🔧"
TERMINAL="💻"
FOLDER="📁"

log() {
    echo -e "${BLUE}${ARROW}${NC} $1" >&2
}

error() {
    echo -e "${RED}${CROSS} Error:${NC} $1" >&2
    exit 1
}

check_dependencies() {
    local deps=("curl")
    echo -e "${WRENCH} Checking dependencies..."
    
    for dep in "${deps[@]}"; do
        if command -v "$dep" >/dev/null 2>&1; then
            echo -e "   ${GREEN}${CHECK}${NC} ${dep} found"
        else
            echo -e "   ${RED}${CROSS}${NC} ${dep} not found"
            error "Required dependency '$dep' not found. Please install it first."
        fi
    done
}

install_leamas() {
    local temp_file
    temp_file=$(mktemp)
    
    echo -e "\n${CYAN}${DOWNLOAD}${NC}  Downloading leamas from GitHub..."
    echo -ne "${DIM}   Fetching latest version...${NC}"
    
    if ! curl -sSL -o "$temp_file" "$LEAMAS_SCRIPT_URL"; then
        echo -ne "\r\033[K"
        error "Failed to download leamas from $LEAMAS_SCRIPT_URL"
    fi
    
    echo -ne "\r\033[K"
    echo -e "${GREEN}${CHECK}${NC} Download complete"
    
    echo -e "\n${PACKAGE} Installing leamas..."
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    mkdir -p "$INSTALL_DIR"
    echo -e "   ${BLUE}${ARROW}${NC} Creating directory: ${CYAN}$INSTALL_DIR${NC}"
    
    cp "$temp_file" "$INSTALL_DIR/leamas"
    echo -e "   ${GREEN}${CHECK}${NC} Copied leamas script"
    
    chmod +x "$INSTALL_DIR/leamas"
    echo -e "   ${GREEN}${CHECK}${NC} Made executable"
    
    rm -f "$temp_file"
    echo -e "   ${GREEN}${CHECK}${NC} Cleaned up temporary files"
    
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    echo -e "\n${GREEN}${SPARKLE} leamas installed successfully!${NC}"
    
    echo -e "\n${BOLD}${YELLOW}Setup Instructions:${NC}"
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    echo -e "\n${TERMINAL} ${BOLD}To use leamas from anywhere, add this to your shell profile:${NC}"
    echo -e "   ${GREEN}export PATH=\"\$HOME/leamas:\$PATH\"${NC}"
    
    echo -e "\n${WRENCH} ${BOLD}Shell-specific setup:${NC}"
    echo -e "   ${CYAN}${DOT} Bash:${NC} ${DIM}echo 'export PATH=\"\$HOME/leamas:\$PATH\"' >> ~/.bashrc${NC}"
    echo -e "   ${CYAN}${DOT} Zsh:${NC}  ${DIM}echo 'export PATH=\"\$HOME/leamas:\$PATH\"' >> ~/.zshrc${NC}"
    echo -e "   ${CYAN}${DOT} Fish:${NC} ${DIM}set -U fish_user_paths \$HOME/leamas \$fish_user_paths${NC}"
    
    echo -e "\n${INFO} ${BOLD}After updating your shell profile:${NC}"
    echo -e "   ${BLUE}${ARROW}${NC} Restart your terminal ${DIM}or${NC} run: ${GREEN}source ~/.bashrc${NC}"
    
    echo -e "\n${ROCKET} ${BOLD}Quick Start:${NC}"
    echo -e "   ${CYAN}${DOT}${NC} Test installation: ${GREEN}leamas --help${NC}"
    echo -e "   ${CYAN}${DOT}${NC} Install agent kits: ${GREEN}leamas agent@<kit-name>${NC}"
    echo -e "   ${CYAN}${DOT}${NC} Install command kits: ${GREEN}leamas command@<kit-name>${NC}"
    echo -e "   ${CYAN}${DOT}${NC} List available kits: ${GREEN}leamas --list${NC}"
    
    echo -e "\n${GLOBE} ${BOLD}Resources:${NC}"
    echo -e "   ${CYAN}${DOT}${NC} Available kits and info: ${BLUE}https://leamas.sh/${NC}"
    
    echo -e "\n${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_header() {
    echo -e "\n${BOLD}${CYAN}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}${CYAN}║${NC}                    ${BOLD}${WHITE}LEAMAS INSTALLER${NC}                           ${BOLD}${CYAN}║${NC}"
    echo -e "${BOLD}${CYAN}║${NC}              ${DIM}Claude Package Manager Installation${NC}              ${BOLD}${CYAN}║${NC}"
    echo -e "${BOLD}${CYAN}╚═══════════════════════════════════════════════════════════════╝${NC}\n"
}

main() {
    print_header
    
    if [[ -f "$INSTALL_DIR/leamas" ]]; then
        echo -e "${YELLOW}${INFO}${NC} leamas is already installed at ${CYAN}$INSTALL_DIR/leamas${NC}"
        echo -e "\n${BOLD}Current Installation:${NC}"
        echo -e "   ${CYAN}${DOT}${NC} Location: ${CYAN}$INSTALL_DIR/leamas${NC}"
        echo -e "   ${CYAN}${DOT}${NC} Check version: ${GREEN}leamas --version${NC}"
        echo -e "   ${CYAN}${DOT}${NC} Get help: ${GREEN}leamas --help${NC}"
        
        echo -e "\n${WARN} ${BOLD}To reinstall or update:${NC}"
        echo -e "   ${RED}rm $INSTALL_DIR/leamas${NC}"
        echo -e "   ${GREEN}curl -sSL https://raw.githubusercontent.com/leamas-ai/leamas.sh/main/install.sh | bash${NC}"
        
        echo -e "\n${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
        exit 0
    fi
    
    check_dependencies
    install_leamas
}

main "$@"