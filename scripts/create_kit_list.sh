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

# Function to create tarball for a kit
create_kit_tarball() {
    local kit_dir="$1"
    local kit_type="$2"
    local kit_name="$3"
    local output_path="kits/${kit_type}s/${kit_name}.tar.gz"
    
    # Create temporary directory for clean tarball
    local temp_dir=$(mktemp -d)
    local kit_temp="$temp_dir/$kit_name"
    mkdir -p "$kit_temp"
    
    # Copy .md files preserving directory structure
    find "$kit_dir" -name "*.md" -type f | while IFS= read -r file; do
        # Get relative path from kit directory
        local rel_path="${file#$kit_dir/}"
        local rel_dir=$(dirname "$rel_path")
        
        # Create subdirectory if needed
        if [[ "$rel_dir" != "." ]]; then
            mkdir -p "$kit_temp/$rel_dir"
        fi
        
        # Copy file preserving structure
        cp "$file" "$kit_temp/$rel_path"
    done
    
    # Create tarball if there are .md files
    if [[ -n "$(find "$kit_temp" -name "*.md" -type f)" ]]; then
        tar -czf "$output_path" -C "$temp_dir" "$kit_name" 2>/dev/null
        success "Created tarball: $output_path"
    else
        warning "No .md files found in $kit_name, skipping tarball"
    fi
    
    # Clean up
    rm -rf "$temp_dir"
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
    
    # Add agents first (sorted) and create tarballs
    if [[ -d "kits/agents" ]]; then
        log "Scanning and packaging agents..."
        while IFS= read -r -d '' agent_dir; do
            local agent_name=$(basename "$agent_dir")
            if [[ -n "$agent_name" && "$agent_name" != "." && "$agent_name" != ".." ]]; then
                echo "agent@$agent_name" >> "$temp_file"
                ((agent_count++))
                success "Found agent: $agent_name"
                create_kit_tarball "$agent_dir" "agent" "$agent_name"
            fi
        done < <(find kits/agents -mindepth 1 -maxdepth 1 -type d -print0 2>/dev/null | sort -z)
    fi
    
    # Add commands second (sorted) and create tarballs
    if [[ -d "kits/commands" ]]; then
        log "Scanning and packaging commands..."
        while IFS= read -r -d '' command_dir; do
            local command_name=$(basename "$command_dir")
            if [[ -n "$command_name" && "$command_name" != "." && "$command_name" != ".." ]]; then
                echo "command@$command_name" >> "$temp_file"
                ((command_count++))
                success "Found command: $command_name"
                create_kit_tarball "$command_dir" "command" "$command_name"
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
    log "Kit list and tarballs are ready for deployment!"
    log "Files created:"
    echo "  - kits/kit_list.txt"
    echo "  - kits/agents/*.tar.gz"
    echo "  - kits/commands/*.tar.gz"
}

# Show usage if help requested
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    echo "Usage: $0"
    echo
    echo "This script:"
    echo "  1. Creates a kit_list.txt file from directories in kits/agents/ and kits/commands/"
    echo "  2. Creates .tar.gz archives for each kit containing only .md files"
    echo
    echo "Output files:"
    echo "  - kits/kit_list.txt (sorted list of available kits)"
    echo "  - kits/agents/{kit-name}.tar.gz (one for each agent kit)"
    echo "  - kits/commands/{kit-name}.tar.gz (one for each command kit)"
    echo
    echo "Kit list format:"
    echo "  agent@kit-name"
    echo "  command@kit-name"
    echo
    echo "The tarballs are created in the same location where the leamas script expects them."
    echo "Run this script from the project root directory."
    exit 0
fi

main "$@"