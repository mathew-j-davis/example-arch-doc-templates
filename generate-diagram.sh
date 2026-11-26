#!/bin/bash
# Simple wrapper - calls concept_pack with this project's paths

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load tool paths from config
source "$SCRIPT_DIR/load-tool-paths.sh"

# Call concept_pack's build-diagram.sh with our parameters
"$CONCEPT_PACK_PATH/build-diagram.sh" \
  "$SCRIPT_DIR/diagram-definitions/example-architecture.yaml" \
  "architecture" \
  "$SCRIPT_DIR"
