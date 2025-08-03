#!/bin/bash

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
BASE_URL="https://leamas.sh"
KITS_DIR="$PROJECT_ROOT/kits"
OUTPUT_DIR="$PROJECT_ROOT"

# Color codes for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# Unicode characters
CHECK="✓"
CROSS="✗"
ARROW="→"
GEAR="⚙️"
PACKAGE="📦"
SPARKLE="✨"

log() {
    echo -e "${BLUE}${ARROW}${NC} $1"
}

error() {
    echo -e "${RED}${CROSS} Error:${NC} $1" >&2
    exit 1
}

success() {
    echo -e "${GREEN}${CHECK}${NC} $1"
}

# Get current timestamp in ISO 8601 format
get_timestamp() {
    date -u +"%Y-%m-%dT%H:%M:%SZ"
}

# Get file modification time in ISO 8601 format
get_file_mod_time() {
    local file="$1"
    if [[ -f "$file" ]]; then
        # Try different date command formats (Linux vs macOS)
        if date --version >/dev/null 2>&1; then
            # GNU date (Linux)
            date -u -d "@$(stat -c %Y "$file")" +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || get_timestamp
        else
            # BSD date (macOS)
            date -u -r "$(stat -f %m "$file" 2>/dev/null || echo 0)" +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || get_timestamp
        fi
    else
        get_timestamp
    fi
}

# Generate XML header
generate_xml_header() {
    cat << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9
                           http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
EOF
}

# Generate XML footer
generate_xml_footer() {
    echo "</urlset>"
}

# Generate URL entry
generate_url_entry() {
    local url="$1"
    local lastmod="$2"
    local changefreq="$3"
    local priority="$4"
    
    cat << EOF
  <url>
    <loc>${url}</loc>
    <lastmod>${lastmod}</lastmod>
    <changefreq>${changefreq}</changefreq>
    <priority>${priority}</priority>
  </url>
EOF
}


# Process tarball file and create URL entry
process_tarball() {
    local tarball="$1"
    local kit_type="$2"  # "agents" or "commands"
    
    # Get tarball filename without path
    local tarball_name=$(basename "$tarball")
    
    # Create URL for the tarball download
    local url="${BASE_URL}/kits/${kit_type}/${tarball_name}"
    local lastmod=$(get_file_mod_time "$tarball")
    
    # Output the URL entry
    generate_url_entry "$url" "$lastmod" "weekly" "0.7"
    
    # Log the found tarball
    echo -e "   ${GREEN}${CHECK}${NC} Found $kit_type tarball: $tarball_name" >&2
}

# Generate sitemap for kits
generate_kits_sitemap() {
    local output_file="$OUTPUT_DIR/sitemap-kits.xml"
    
    log "Scanning kits directories for tarballs..."
    
    if [[ ! -d "$KITS_DIR" ]]; then
        error "Kits directory not found: $KITS_DIR"
    fi
    
    {
        generate_xml_header
        echo ""
        echo "  <!-- Kits Index Pages -->"
        
        # Main kits page
        generate_url_entry "${BASE_URL}/kits" "$(get_timestamp)" "daily" "0.9"
        
        # Check if agents directory exists and has tarballs
        if [[ -d "$KITS_DIR/agents" ]] && [[ -n "$(find "$KITS_DIR/agents" -name "*.tar.gz" | head -1)" ]]; then
            generate_url_entry "${BASE_URL}/kits/agents" "$(get_timestamp)" "daily" "0.8"
        fi
        
        # Check if commands directory exists and has tarballs
        if [[ -d "$KITS_DIR/commands" ]] && [[ -n "$(find "$KITS_DIR/commands" -name "*.tar.gz" | head -1)" ]]; then
            generate_url_entry "${BASE_URL}/kits/commands" "$(get_timestamp)" "daily" "0.8"
        fi
        
        echo ""
        echo "  <!-- Agent Kit Tarballs -->"
        
        # Process agent tarballs
        if [[ -d "$KITS_DIR/agents" ]]; then
            find "$KITS_DIR/agents" -name "*.tar.gz" -type f | sort | while read -r tarball; do
                process_tarball "$tarball" "agents"
            done
        fi
        
        echo ""
        echo "  <!-- Command Kit Tarballs -->"
        
        # Process command tarballs
        if [[ -d "$KITS_DIR/commands" ]]; then
            find "$KITS_DIR/commands" -name "*.tar.gz" -type f | sort | while read -r tarball; do
                process_tarball "$tarball" "commands"
            done
        fi
        
        echo ""
        generate_xml_footer
    } > "$output_file"
    
    success "Generated kits sitemap: $output_file"
}

# Update robots.txt to reference the kits sitemap
update_robots_txt() {
    local robots_file="$OUTPUT_DIR/robots.txt"
    
    if [[ -f "$robots_file" ]]; then
        log "Checking robots.txt for sitemap reference..."
        
        # Check if sitemap-kits.xml reference already exists
        if ! grep -q "sitemap-kits.xml" "$robots_file"; then
            log "Adding sitemap-kits.xml reference to robots.txt"
            echo "Sitemap: ${BASE_URL}/sitemap-kits.xml" >> "$robots_file"
        else
            log "sitemap-kits.xml already referenced in robots.txt"
        fi
    fi
}

# Generate statistics
generate_statistics() {
    local kits_count=0
    local agents_count=0
    local commands_count=0
    
    if [[ -f "$OUTPUT_DIR/sitemap-kits.xml" ]]; then
        kits_count=$(grep -c "<url>" "$OUTPUT_DIR/sitemap-kits.xml" || echo 0)
    fi
    
    # Count agent tarballs
    if [[ -d "$KITS_DIR/agents" ]]; then
        agents_count=$(find "$KITS_DIR/agents" -name "*.tar.gz" -type f | wc -l | tr -d ' ')
    fi
    
    # Count command tarballs
    if [[ -d "$KITS_DIR/commands" ]]; then
        commands_count=$(find "$KITS_DIR/commands" -name "*.tar.gz" -type f | wc -l | tr -d ' ')
    fi
    
    echo -e "\n${SPARKLE} ${BOLD}Sitemap Generation Complete!${NC}"
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${PACKAGE} Total URLs: ${GREEN}$kits_count${NC}"
    echo -e "   ${CYAN}${CHECK}${NC} Agent tarballs: ${GREEN}$agents_count${NC}"
    echo -e "   ${CYAN}${CHECK}${NC} Command tarballs: ${GREEN}$commands_count${NC}"
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    echo -e "\n${BOLD}File generated:${NC}"
    echo -e "  ${CYAN}${CHECK}${NC} sitemap-kits.xml"
    
    echo -e "\n${BOLD}Next steps:${NC}"
    echo -e "  ${ARROW} Submit sitemap to search engines"
    echo -e "  ${ARROW} Set up automated regeneration when kits are updated"
    echo ""
}

# Print usage information
print_usage() {
    cat << EOF
${BOLD}${CYAN}Leamas Kits Sitemap Generator${NC}

${BOLD}Usage:${NC} $0 [OPTIONS]

${BOLD}Description:${NC}
  Generates sitemap-kits.xml by scanning the kits/agents/ and kits/commands/
  directories for actual .md files and creating proper sitemap entries.

${BOLD}Options:${NC}
  -h, --help          Show this help message
  -v, --verbose       Enable verbose output

${BOLD}Configuration:${NC}
  Base URL: $BASE_URL
  Kits Dir: $KITS_DIR
  Output:   $OUTPUT_DIR/sitemap-kits.xml

${BOLD}What it scans:${NC}
  - All .tar.gz files in kits/agents/ (as downloadable tarballs)
  - All .tar.gz files in kits/commands/ (as downloadable tarballs)
  - Creates URLs like: /kits/agents/tarball-name.tar.gz

EOF
}

# Main function
main() {
    local verbose=false
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                print_usage
                exit 0
                ;;
            -v|--verbose)
                verbose=true
                shift
                ;;
            *)
                error "Unknown option: $1"
                ;;
        esac
    done
    
    echo -e "${BOLD}${CYAN}${GEAR} Leamas Kits Sitemap Generator${NC}\n"
    
    # Create output directory if it doesn't exist
    mkdir -p "$OUTPUT_DIR"
    
    # Generate kits sitemap
    generate_kits_sitemap
    
    # Update robots.txt
    update_robots_txt
    
    # Show statistics
    generate_statistics
}

# Run main function with all arguments
main "$@"