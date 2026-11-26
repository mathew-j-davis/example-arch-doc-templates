#!/bin/bash
# Simple wrapper - builds diagrams + presentation for this project

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔨 Building Example Concept Pack"
echo "================================="
echo ""

# Step 1: Generate diagram(s)
echo "Step 1: Generating architecture diagram..."
"$SCRIPT_DIR/generate-diagram.sh"

# Step 2: Generate PowerPoint presentation
echo ""
echo "Step 2: Generating PowerPoint presentation..."
"$SCRIPT_DIR/generate-presentation.sh"

echo ""
echo "✅ Build complete!"
