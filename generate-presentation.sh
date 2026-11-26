#!/bin/bash
# Simple wrapper - generates PowerPoint from markdown

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load tool paths from config
source "$SCRIPT_DIR/load-tool-paths.sh"

# Ensure output directory exists
mkdir -p "$SCRIPT_DIR/output-powerpoint"

# Call concept_pack's build-presentation.sh with our parameters
"$CONCEPT_PACK_PATH/build-presentation.sh" \
  "$SCRIPT_DIR/example-concept-pack.md" \
  "$SCRIPT_DIR/output-powerpoint" \
  "$SCRIPT_DIR/presentation-config.yaml"
