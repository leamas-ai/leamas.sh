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

# Function to check if a directory is already a git subtree
is_subtree() {
    local dir="$1"
    local relative_path="${dir#./}"
    
    # If no commits exist yet, nothing can be a subtree
    if ! git rev-parse HEAD >/dev/null 2>&1; then
        return 1  # Not a subtree (no commits yet)
    fi
    
    # Check if this path exists in git subtree list
    if git log --grep="git-subtree-dir: $relative_path" --oneline 2>/dev/null | grep -q "git-subtree-dir: $relative_path"; then
        return 0  # Is a subtree
    else
        return 1  # Not a subtree
    fi
}

# Function to get the remote origin URL from a git directory
get_remote_url() {
    local git_dir="$1"
    if [[ -f "$git_dir/config" ]]; then
        grep -A1 '\[remote "origin"\]' "$git_dir/config" | grep "url =" | sed 's/.*url = //' | head -1
    fi
}

# Function to convert a git clone to subtree
convert_to_subtree() {
    local kit_path="$1"
    local remote_url="$2"
    local kit_name=$(basename "$kit_path")
    
    log "Converting $kit_path to subtree..."
    
    # Get the current branch name from the git clone
    local current_branch="main"
    if [[ -f "$kit_path/.git/HEAD" ]]; then
        local head_content=$(cat "$kit_path/.git/HEAD")
        if [[ "$head_content" =~ ref:\ refs/heads/(.+) ]]; then
            current_branch="${BASH_REMATCH[1]}"
        fi
    fi
    
    # Store kit files temporarily
    local temp_dir=$(mktemp -d)
    log "Backing up kit files to $temp_dir"
    
    # Copy all files except .git directory
    cd "$kit_path"
    find . -type f ! -path "*/.git/*" | while IFS= read -r file; do
        mkdir -p "$temp_dir/$kit_path/$(dirname "$file")"
        cp "$file" "$temp_dir/$kit_path/$file"
    done
    cd - > /dev/null
    
    # Remove the original directory
    log "Removing original git clone directory"
    rm -rf "$kit_path"
    
    # Add as subtree
    log "Adding as git subtree from $remote_url (branch: $current_branch)"
    if git subtree add --prefix="$kit_path" "$remote_url" "$current_branch" --squash; then
        success "Successfully converted $kit_name to subtree"
        
        # Clean up temp directory
        rm -rf "$temp_dir"
        return 0
    else
        warning "Failed to add subtree, restoring original files"
        
        # Restore from backup
        mkdir -p "$kit_path"
        if [[ -d "$temp_dir/$kit_path" ]]; then
            cp -r "$temp_dir/$kit_path"/* "$kit_path/" 2>/dev/null || true
        fi
        rm -rf "$temp_dir"
        
        error "Could not convert $kit_name to subtree"
        return 1
    fi
}

# Main function
main() {
    log "Starting git subtree conversion process..."
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        error "Not in a git repository. Please run this script from the project root."
        exit 1
    fi
    
    # Check if there are uncommitted changes
    if ! git diff-index --quiet HEAD 2>/dev/null; then
        error "Working tree has modifications. Please commit or stash changes before running this script."
        echo "Run: git add . && git commit -m 'Initial commit before subtree conversion'"
        exit 1
    fi
    
    # Check if we have at least one commit
    if ! git rev-parse HEAD >/dev/null 2>&1; then
        error "No commits found. Please make an initial commit before running this script."
        echo "Run: git add . && git commit -m 'Initial commit'"
        exit 1
    fi
    
    local converted=0
    local skipped=0
    local failed=0
    
    # Find all .git directories in kits/
    while IFS= read -r -d '' git_dir; do
        local kit_path=$(dirname "$git_dir")
        local kit_name=$(basename "$kit_path")
        local relative_path="${kit_path#./}"
        
        log "Processing kit: $kit_name"
        
        # Check if already a subtree
        if is_subtree "$kit_path"; then
            success "Kit '$kit_name' is already a subtree - skipping"
            ((skipped++))
            continue
        fi
        
        # Get remote URL
        local remote_url
        remote_url=$(get_remote_url "$git_dir")
        
        if [[ -z "$remote_url" ]]; then
            warning "Could not determine remote URL for $kit_name - skipping"
            ((failed++))
            continue
        fi
        
        log "Found git clone: $kit_name (remote: $remote_url)"
        
        # Convert to subtree
        if convert_to_subtree "$kit_path" "$remote_url"; then
            ((converted++))
        else
            ((failed++))
        fi
        
    done < <(find kits/agents kits/commands -name ".git" -type d -print0 2>/dev/null)
    
    # Summary
    echo
    log "Conversion complete!"
    success "Converted: $converted kits"
    [[ $skipped -gt 0 ]] && success "Skipped (already subtrees): $skipped kits"
    [[ $failed -gt 0 ]] && warning "Failed: $failed kits"
    
    if [[ $converted -gt 0 ]]; then
        echo
        log "Next steps:"
        echo "1. Review the changes: git status"
        echo "2. Commit the subtree additions: git commit -m 'Convert kits to git subtrees'"
        echo "3. Update kits in future with: git subtree pull --prefix=kits/agents/KIT_NAME REMOTE_URL main --squash"
    fi
}

# Show usage if help requested
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    echo "Usage: $0"
    echo
    echo "This script converts git clones in kits/agents/ and kits/commands/ to git subtrees."
    echo "It will:"
    echo "  - Scan for .git repositories in kit directories"
    echo "  - Skip directories that are already git subtrees"
    echo "  - Convert git clones to subtrees preserving the remote URL"
    echo "  - Maintain all kit files during the conversion"
    echo
    echo "Run this script from the project root directory."
    exit 0
fi

main "$@"