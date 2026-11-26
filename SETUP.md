# Complete Setup Guide

This guide walks you through setting up the complete diagram generation system from scratch.

## Overview

The system consists of three main components:

1. **boxesandarrows** - Core SVG rendering engine
2. **concept_pack** - Table-based diagram generator (converts YAML to boxesandarrows format)
3. **boxwatcher** - Build automation and live-reload server

## Prerequisites

- **Node.js** 16+ (for boxesandarrows and boxwatcher)
- **Python 3** (for concept_pack table-to-diagram)
- **Git** (to clone repositories)

Check your versions:
```bash
node --version    # Should be 16.0.0 or higher
python3 --version # Should be 3.7 or higher
git --version
```

## Step 1: Clone the Repositories

Create a workspace directory and clone all three tools:

```bash
# Create workspace
mkdir diagram-tools
cd diagram-tools

# Clone the three repositories
git clone https://github.com/mathew-j-davis/boxesandarrows.git
git clone https://github.com/mathew-j-davis/concept_pack.git
git clone https://github.com/mathew-j-davis/boxwatcher.git

# Your directory structure should now be:
# diagram-tools/
#   ├── boxesandarrows/
#   ├── concept_pack/
#   └── boxwatcher/
```

## Step 2: Set Up Your Project

Create your project directory alongside the tools:

```bash
# Still in diagram-tools/
mkdir my-architecture
cd my-architecture

# Copy the template files
# (or start from scratch following the structure below)
```

Your final structure will be:
```
diagram-tools/
├── boxesandarrows/          # SVG rendering engine
├── concept_pack/            # Table diagram generator
├── boxwatcher/              # Build automation
└── my-architecture/         # Your project (this directory)
    ├── diagram-definitions/ # Diagram source files
    ├── icons/              # Optional icon library
    ├── output/             # Generated diagrams
    ├── builds.csv          # Build configuration
    ├── build-all.js        # Build script
    ├── generate-pngs.js    # PNG export script
    ├── watch.sh            # Live-reload script
    └── package.json        # Node dependencies
```

## Step 3: Install Dependencies

### In your project directory:

```bash
# In my-architecture/
npm init -y

# Install diagram generation dependencies
npm install @resvg/resvg-js sharp

# Install development tools (optional, for watch mode)
npm install -g nodemon live-server
```

### No installation needed for boxesandarrows or concept_pack
They are run directly from their source directories using `node` and `python3`.

## Step 4: Create Project Files

### 4.1 Create builds.csv

This file defines which diagrams to build:

```bash
cat > diagram-definitions/builds.csv << 'EOF'
name,command
architecture,"python3 ../concept_pack/table-to-diagram.py diagram-definitions/example-architecture.yaml output/architecture-positioned.yaml && node ../boxesandarrows/src/index.js -y output/architecture-positioned.yaml -r svg -o output/architecture"
EOF
```

### 4.2 Create build-all.js

```bash
cat > build-all.js << 'EOF'
#!/usr/bin/env node
/**
 * Build all diagrams defined in builds.csv
 */

const fs = require('fs');
const { execSync } = require('child_process');
const path = require('path');

const BUILDS_CSV = path.join(__dirname, 'diagram-definitions', 'builds.csv');

function parseCsvLine(line) {
  const values = [];
  let current = '';
  let inQuotes = false;

  for (let i = 0; i < line.length; i++) {
    const char = line[i];
    if (char === '"') {
      inQuotes = !inQuotes;
    } else if (char === ',' && !inQuotes) {
      values.push(current.trim());
      current = '';
    } else {
      current += char;
    }
  }
  values.push(current.trim());
  return values;
}

function main() {
  if (!fs.existsSync(BUILDS_CSV)) {
    console.error(`Error: ${BUILDS_CSV} not found`);
    process.exit(1);
  }

  const csvContent = fs.readFileSync(BUILDS_CSV, 'utf8');
  const lines = csvContent.trim().split('\n');
  const headers = parseCsvLine(lines[0]);

  const builds = lines.slice(1)
    .filter(line => line.trim() && !line.startsWith('#'))
    .map(line => {
      const values = parseCsvLine(line);
      return { name: values[0], command: values[1] };
    });

  console.log(`🔨 Building ${builds.length} diagram(s)...\n`);

  builds.forEach(build => {
    console.log(`Building: ${build.name}`);
    try {
      execSync(build.command, { stdio: 'inherit', cwd: __dirname });
      console.log(`✅ ${build.name} completed\n`);
    } catch (error) {
      console.error(`❌ ${build.name} failed\n`);
    }
  });
}

main();
EOF

chmod +x build-all.js
```

### 4.3 Create watch.sh

For live-reload during development:

```bash
cat > watch.sh << 'EOF'
#!/bin/bash
# Watch and rebuild diagrams with auto-reload

# Start live-server in background
echo "Starting live-server on http://localhost:8080..."
live-server output --port=8080 --quiet &
LIVE_SERVER_PID=$!

# Watch for changes
echo "Watching diagram-definitions/ and icons/ for changes..."
nodemon --watch diagram-definitions \
        --watch icons \
        --ext yaml,csv,json \
        --exec "node ./build-all.js"

# Cleanup on exit
trap "kill $LIVE_SERVER_PID" EXIT
EOF

chmod +x watch.sh
```

### 4.4 Create generate-pngs.js

For PNG export (PowerPoint, Word, etc.):

```bash
cat > generate-pngs.js << 'EOF'
#!/usr/bin/env node
/**
 * Generate PNG files from SVG diagrams
 * Uses @resvg/resvg-js for high-quality conversion
 */

const fs = require('fs');
const path = require('path');
const { Resvg } = require('@resvg/resvg-js');

const OUTPUT_DIR = path.join(__dirname, 'output');
const DPI = 300;
const SCALE = DPI / 96; // SVG default is 96 DPI

// Find all SVG files in output directory
const svgFiles = fs.readdirSync(OUTPUT_DIR)
  .filter(f => f.endsWith('.svg'))
  .map(f => path.join(OUTPUT_DIR, f));

console.log(`🖼️  Converting ${svgFiles.length} SVG file(s) to PNG...\n`);

svgFiles.forEach(svgPath => {
  const svgContent = fs.readFileSync(svgPath, 'utf8');
  const pngPath = svgPath.replace('.svg', '.png');

  console.log(`Converting: ${path.basename(svgPath)}`);

  const resvg = new Resvg(svgContent, {
    fitTo: {
      mode: 'zoom',
      value: SCALE
    }
  });

  const pngData = resvg.render();
  const pngBuffer = pngData.asPng();

  fs.writeFileSync(pngPath, pngBuffer);
  console.log(`✅ Created: ${path.basename(pngPath)}\n`);
});

console.log('Done!');
EOF

chmod +x generate-pngs.js
```

## Step 5: Create Your First Diagram

### 5.1 Create diagram directory structure:

```bash
mkdir -p diagram-definitions
mkdir -p output
mkdir -p icons  # Optional, for icon support
```

### 5.2 Create example-architecture.yaml:

```yaml
# diagram-definitions/example-architecture.yaml
table:
  width: 46.6
  height: 20.0
  spacing: 0.1
  start_x: 2.0
  start_y: 2.0

  rows:
    - name: main_area
      height: auto
      columns:
        # Users column
        - width: 8.0
          cells_stack:
            - label: "USERS"
              style: header
              height: 2.0
            - label: "Customers"
              height: auto
            - label: "Staff"
              height: auto

        # Main application layers
        - width: auto
          table:
            column_widths: [8.0, auto]
            rows:
              # Presentation Layer
              - height: auto
                columns:
                  - cell:
                      label: "PRESENTATION"
                      style: header
                  - table:
                      rows:
                        - height: auto
                          columns:
                            - cell:
                                label: "Web UI"
                            - cell:
                                label: "Mobile App"

              # Business Logic Layer
              - height: auto
                columns:
                  - cell:
                      label: "BUSINESS LOGIC"
                      style: header
                  - table:
                      rows:
                        - height: auto
                          columns:
                            - cell:
                                label: "Order Service"
                            - cell:
                                label: "User Service"
```

### 5.3 Create diagram-config.yaml:

```yaml
# diagram-definitions/diagram-config.yaml
# Color palette and styling

colors:
  header: '#1F4A70'
  default: '#2E5C8A'
  foundation: '#7FA8C9'

styles:
  font_size: 18
  font_weight: 500
  font_family: 'Arial, sans-serif'
  
  header:
    font_size: 20
    font_weight: 700
    fill: '#1F4A70'
    textcolor: '#FFFFFF'
```

## Step 6: Build Your First Diagram

```bash
# Build once
node build-all.js

# Or use watch mode for live updates
./watch.sh
```

Your diagram will be generated at `output/architecture.svg`!

## Step 7: Generate PNG (Optional)

For use in PowerPoint or Word:

```bash
node generate-pngs.js
```

This creates `output/architecture.png` at 300 DPI.

## Usage Patterns

### Quick single build
```bash
node build-all.js
```

### Development with live-reload
```bash
./watch.sh
# Edit diagram-definitions/example-architecture.yaml
# Browser auto-refreshes!
```

### Export for presentations
```bash
node build-all.js      # Generate SVG
node generate-pngs.js  # Convert to PNG
```

## Adding More Diagrams

Edit `diagram-definitions/builds.csv` to add more diagrams:

```csv
name,command
architecture,"python3 ../concept_pack/table-to-diagram.py diagram-definitions/example-architecture.yaml output/architecture-positioned.yaml && node ../boxesandarrows/src/index.js -y output/architecture-positioned.yaml -r svg -o output/architecture"
deployment,"python3 ../concept_pack/table-to-diagram.py diagram-definitions/deployment.yaml output/deployment-positioned.yaml && node ../boxesandarrows/src/index.js -y output/deployment-positioned.yaml -r svg -o output/deployment"
network,"node ../boxesandarrows/src/index.js -n diagram-definitions/network-nodes.csv -e diagram-definitions/network-edges.csv -r svg -o output/network"
```

## Troubleshooting

### "python3: command not found"
Install Python 3: https://www.python.org/downloads/

### "node: command not found"
Install Node.js: https://nodejs.org/

### "nodemon: command not found"
Install globally: `npm install -g nodemon live-server`

### SVG generates but PNG fails
Make sure dependencies are installed: `npm install`

### "Module not found" errors
Make sure you're in your project directory and ran `npm install`

### Paths don't work
Check that boxesandarrows and concept_pack are in the right relative locations (../boxesandarrows and ../concept_pack from your project directory)

## Next Steps

1. Read [ICON-USAGE.md](ICON-USAGE.md) to add icons to your diagrams
2. See [QUICKSTART.md](QUICKSTART.md) for quick reference
3. Check [PROJECT-STRUCTURE.md](PROJECT-STRUCTURE.md) for file organization details
4. Look at ai-roadmap/ for a complete example with PowerPoint generation

## Repository Links

- **boxesandarrows**: https://github.com/mathew-j-davis/boxesandarrows
- **concept_pack**: https://github.com/mathew-j-davis/concept_pack
- **boxwatcher**: https://github.com/mathew-j-davis/boxwatcher

## License

MIT
