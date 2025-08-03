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
    local output_file="kits/kit_list.txt"
    
    log "Creating kit list from directories in kits/..."
    
    # Check if kits directories exist
    if [[ ! -d "kits" ]]; then
        error "kits/ directory not found. Please run this script from the project root."
        exit 1
    fi
    
    # Create temporary file
    local temp_file=$(mktemp)
    
    # Count kits found
    local agent_count=0
    local command_count=0
    
    # Add agents first (sorted)
    if [[ -d "kits/agents" ]]; then
        log "Scanning agents..."
        while IFS= read -r -d '' agent_dir; do
            local agent_name=$(basename "$agent_dir")
            if [[ -n "$agent_name" && "$agent_name" != "." && "$agent_name" != ".." ]]; then
                echo "agent@$agent_name" >> "$temp_file"
                ((agent_count++))
                success "Found agent: $agent_name"
            fi
        done < <(find kits/agents -mindepth 1 -maxdepth 1 -type d -print0 2>/dev/null | sort -z)
    fi
    
    # Add commands second (sorted)
    if [[ -d "kits/commands" ]]; then
        log "Scanning commands..."
        while IFS= read -r -d '' command_dir; do
            local command_name=$(basename "$command_dir")
            if [[ -n "$command_name" && "$command_name" != "." && "$command_name" != ".." ]]; then
                echo "command@$command_name" >> "$temp_file"
                ((command_count++))
                success "Found command: $command_name"
            fi
        done < <(find kits/commands -mindepth 1 -maxdepth 1 -type d -print0 2>/dev/null | sort -z)
    fi
    
    # Sort the file (agents will naturally come before commands due to alphabetical order)
    sort "$temp_file" > "$output_file"
    rm -f "$temp_file"
    
    # Summary
    echo
    if [[ $agent_count -eq 0 && $command_count -eq 0 ]]; then
        warning "No kits found in kits/agents/ or kits/commands/"
        echo "# No kits available" > "$output_file"
    else
        success "Kit list created: $output_file"
        success "Total agents: $agent_count"
        success "Total commands: $command_count"
        success "Total kits: $((agent_count + command_count))"
        echo
        log "Preview of $output_file:"
        head -10 "$output_file" | sed 's/^/  /'
        if [[ $(wc -l < "$output_file") -gt 10 ]]; then
            echo "  ... and $(($(wc -l < "$output_file") - 10)) more"
        fi
    fi
    
    echo
    log "Kit list is ready for deployment to leamas.sh/kits/kit_list.txt"
}

# Show usage if help requested
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    echo "Usage: $0"
    echo
    echo "This script creates a kit_list.txt file based on directories found in:"
    echo "  - kits/agents/"
    echo "  - kits/commands/"
    echo
    echo "Output format:"
    echo "  agent@kit-name"
    echo "  command@kit-name"
    echo
    echo "The list is sorted with agents first, then commands."
    echo "Run this script from the project root directory."
    echo
    echo "The generated file will be: kits/kit_list.txt"
    exit 0
fi

main "$@"