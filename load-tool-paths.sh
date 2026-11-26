#!/bin/bash
# Load tool paths from diagram-tools.config.yaml
# Source this file in other scripts to get tool paths

# Find the config file (should be in project root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/diagram-tools.config.yaml"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "⚠️  Config file not found: $CONFIG_FILE" >&2
    echo "   Using default paths..." >&2
    export BOXESANDARROWS_PATH="$SCRIPT_DIR/../boxesandarrows"
    export CONCEPT_PACK_PATH="$SCRIPT_DIR/../concept_pack"
    export BOXWATCHER_PATH="$SCRIPT_DIR/../boxwatcher"
    return 0
fi

# Parse YAML config (simple parser for key: value format)
parse_yaml() {
    local key=$1
    grep "^${key}:" "$CONFIG_FILE" | sed 's/^[^:]*:[[:space:]]*//' | sed 's/#.*//' | xargs
}

# Read paths from config
BOXESANDARROWS_PATH=$(parse_yaml "boxesandarrows_path")
CONCEPT_PACK_PATH=$(parse_yaml "concept_pack_path")
BOXWATCHER_PATH=$(parse_yaml "boxwatcher_path")

# Use defaults if not set
BOXESANDARROWS_PATH="${BOXESANDARROWS_PATH:-../boxesandarrows}"
CONCEPT_PACK_PATH="${CONCEPT_PACK_PATH:-../concept_pack}"
BOXWATCHER_PATH="${BOXWATCHER_PATH:-../boxwatcher}"

# Convert to absolute paths
BOXESANDARROWS_PATH="$(cd "$SCRIPT_DIR" && cd "$BOXESANDARROWS_PATH" 2>/dev/null && pwd)" || BOXESANDARROWS_PATH="$SCRIPT_DIR/$BOXESANDARROWS_PATH"
CONCEPT_PACK_PATH="$(cd "$SCRIPT_DIR" && cd "$CONCEPT_PACK_PATH" 2>/dev/null && pwd)" || CONCEPT_PACK_PATH="$SCRIPT_DIR/$CONCEPT_PACK_PATH"
BOXWATCHER_PATH="$(cd "$SCRIPT_DIR" && cd "$BOXWATCHER_PATH" 2>/dev/null && pwd)" || BOXWATCHER_PATH="$SCRIPT_DIR/$BOXWATCHER_PATH"

# Export for use in other scripts
export BOXESANDARROWS_PATH
export CONCEPT_PACK_PATH
export BOXWATCHER_PATH

# Optional: Print loaded paths if DEBUG is set
if [ -n "$DEBUG" ]; then
    echo "Tool paths loaded from $CONFIG_FILE:" >&2
    echo "  BOXESANDARROWS_PATH: $BOXESANDARROWS_PATH" >&2
    echo "  CONCEPT_PACK_PATH: $CONCEPT_PACK_PATH" >&2
    echo "  BOXWATCHER_PATH: $BOXWATCHER_PATH" >&2
fi
