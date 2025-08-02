#!/bin/bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() {
    echo -e "${BLUE}==>${NC} $1"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

# Main function
main() {
    log "Scanning for .git directories in kits/agents/ and kits/commands/..."
    
    # Check if kits directories exist
    if [[ ! -d "kits/agents" && ! -d "kits/commands" ]]; then
        error "Neither kits/agents/ nor kits/commands/ directories found."
        echo "Please run this script from the project root directory."
        exit 1
    fi
    
    local removed_count=0
    local total_found=0
    
    # Find all .git directories in kits/
    while IFS= read -r -d '' git_dir; do
        ((total_found++))
        local kit_path=$(dirname "$git_dir")
        local kit_name=$(basename "$kit_path")
        local kit_type=$(basename "$(dirname "$kit_path")")
        
        log "Found .git directory in $kit_type/$kit_name"
        
        # Remove the .git directory
        if rm -rf "$git_dir"; then
            success "Removed .git directory from $kit_type/$kit_name"
            ((removed_count++))
        else
            error "Failed to remove .git directory from $kit_type/$kit_name"
        fi
        
    done < <(find kits/agents kits/commands -name ".git" -type d -print0 2>/dev/null)
    
    # Summary
    echo
    if [[ $total_found -eq 0 ]]; then
        success "No .git directories found in kits/"
    else
        log "Removal complete!"
        success "Found: $total_found .git directories"
        success "Removed: $removed_count .git directories"
        
        if [[ $removed_count -lt $total_found ]]; then
            warning "Failed to remove $((total_found - removed_count)) .git directories"
        fi
        
        echo
        log "All kit .git directories have been removed."
        log "The kits are now regular directories with just the kit files."
        log "You can now commit without git warnings:"
        echo "  git add ."
        echo "  git commit -m 'Remove git metadata from kits'"
    fi
}

# Show usage if help requested
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    echo "Usage: $0"
    echo
    echo "This script removes all .git directories from kits/agents/ and kits/commands/."
    echo "This converts git clones to regular directories containing just the kit files."
    echo
    echo "Run this script from the project root directory."
    echo
    echo "After running this script, you can commit without git warnings."
    exit 0
fi

main "$@"