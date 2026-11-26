#!/bin/bash
# Watch mode - calls BoxWatcher tools directly

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load tool paths from config
source "$SCRIPT_DIR/load-tool-paths.sh"

echo "🔍 Starting watch mode..."
echo ""
echo "Using BoxWatcher from: $BOXWATCHER_PATH"
echo ""

# Check if BoxWatcher is available
if [ ! -f "$BOXWATCHER_PATH/watch-and-serve.sh" ]; then
    echo "❌ BoxWatcher not found at $BOXWATCHER_PATH"
    echo "   Update diagram-tools.config.yaml with correct path"
    exit 1
fi

# Check dependencies
if ! command -v nodemon &> /dev/null; then
    echo "❌ nodemon not found. Install with:"
    echo "   npm install -g nodemon"
    exit 1
fi

if ! command -v live-server &> /dev/null; then
    echo "❌ live-server not found. Install with:"
    echo "   npm install -g live-server"
    exit 1
fi

# Run BoxWatcher's watch-and-serve from this project directory
cd "$SCRIPT_DIR"
exec "$BOXWATCHER_PATH/watch-and-serve.sh"
