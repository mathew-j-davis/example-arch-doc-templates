# System Overview - Concept Pack Architecture

This document explains how all the pieces fit together.

## The Complete Pipeline

```
YAML Architecture              Markdown Content
      ↓                              ↓
table-to-diagram.py         (stays as markdown)
      ↓                              ↓
Positioned Boxes YAML              ↓
      ↓                              ↓
boxesandarrows                     ↓
      ↓                              ↓
  SVG Diagram                       ↓
      ↓                              ↓
PNG Converter                       ↓
      ↓                              ↓
  PNG Image  ←────────────────────  ↓
                                    ↓
                          Presentation Builder
                                    ↓
                              PowerPoint
```

## Components

### 1. Table-Based Architecture (concept_pack)

**Purpose:** Define architecture diagrams in clean, semantic YAML

**Input:** `example-architecture.yaml`
```yaml
table:
  rows:
    - columns:
        - cells_stack:  # Vertical stack
            - label: "Header"
            - label: "Cell 1"
        - table:        # Nested 2D layout
            rows: [...]
```

**Output:** Positioned boxes YAML for boxesandarrows

**Key features:**
- Automatic layout calculation
- No manual positioning needed
- Hierarchical nesting (tables in tables)
- `cells_stack` for simple vertical stacks

### 2. BoxesAndArrows (core renderer)

**Purpose:** Render positioned boxes to SVG

**Input:** Positioned boxes YAML with explicit coordinates

**Output:** SVG diagram

**What it does:**
- Draws boxes, edges, text
- Handles anchors and positioning
- Applies styles
- Generates clean SVG

### 3. BoxWatcher (build automation)

**Purpose:** Watch files, rebuild automatically, serve with live-reload

**Key files:**
- `builds.csv` - Define what to build
- `boxwatcher.config.json` - Configuration
- `build-all.js` - Orchestrator
- `generate-pngs.js` - PNG conversion with caching
- `watch-and-serve.sh` - Watch mode + live server

**Features:**
- CSV-driven builds
- Content-based PNG caching (only regenerate when changed)
- Live-reload browser
- Configurable for any project
- **No ImageMagick needed** - Uses sharp + @resvg/resvg-js (Node packages)

**PNG Generation:**
- Uses existing BoxWatcher logic (no duplication!)
- Content-based caching (hash comparison, not timestamp)
- Node.js-based (sharp + @resvg/resvg-js)
- Works cross-platform without installing CLI tools
- Same code that powers ai-roadmap

### 4. Presentation Builder (ai-roadmap)

**Purpose:** Convert markdown to PowerPoint

**Input:** Markdown with slide metadata
```markdown
# Title
slide-type:: image-slide
image:: output/architecture.png

Content here...
```

**Output:** PowerPoint (.pptx)

**Features:**
- Multiple slide types
- Image embedding
- Professional themes
- Automated layout

## File Flow

### Diagram Generation

```
diagram-definitions/
  example-architecture.yaml          # YOU EDIT THIS
         ↓
  example-architecture-positioned.yaml  # Generated
         ↓
output/
  architecture.svg                   # Generated
  architecture.png                   # Generated (optional)
```

### Presentation Generation

```
example-concept-pack.md             # YOU EDIT THIS
         +
output/architecture.png             # From above
         ↓
output-powerpoint/
  example-concept-pack.pptx         # Generated
```

## Configuration Files

### boxwatcher.config.json
```json
{
  "boxesandarrows": {
    "path": "../boxesandarrows"  // Where to find renderer
  },
  "paths": {
    "definitions": "./diagram-definitions",
    "output": "./output"
  }
}
```

### builds.csv
```csv
name,command,enabled
architecture,<full build command>,true
```

Each row is a build target. The command can chain multiple steps.

### png-config.json (optional)
```json
{
  "enabled": true,
  "defaultScale": 2,
  "diagrams": {
    "architecture": { "scale": 3 }  // Per-diagram settings
  }
}
```

## Scripts

### generate-diagram.sh
Single-purpose: Generate one diagram (SVG + PNG)

```bash
./generate-diagram.sh
```

**Does:**
1. table-to-diagram.py
2. boxesandarrows
3. PNG conversion

### build-all.sh
Complete build: Everything including PowerPoint

```bash
./build-all.sh
```

**Does:**
1. Generate diagram (via generate-diagram.sh)
2. Generate PowerPoint (via ai-roadmap)

### setup-boxwatcher.sh
One-time setup: Copy boxwatcher files to this project

```bash
./setup-boxwatcher.sh
npm install
```

### watch-and-serve.sh
Development mode: Auto-rebuild + live-reload

```bash
./watch-and-serve.sh
```

**Runs:**
- nodemon watching diagram-definitions/
- live-server serving output/
- Auto-rebuild on changes
- Auto-refresh browser

## Customization Points

### 1. Architecture Diagram

**File:** `diagram-definitions/example-architecture.yaml`

**What you can change:**
- Labels
- Number of layers
- Number of components per layer
- Sidebar content
- Cross-cutting concerns

**What stays the same:**
- Overall layout structure
- Color scheme (unless you edit conceptual-arch-config.yaml)
- Positioning logic

### 2. Presentation Content

**File:** `example-concept-pack.md`

**What you can change:**
- Titles
- Content
- Number of slides
- Slide types

**Reference the diagram:**
```markdown
image:: output/architecture.png
```

### 3. Build Pipeline

**File:** `diagram-definitions/builds.csv`

**What you can change:**
- Commands
- Which diagrams to build
- Build order

## Dependencies

### Required
- Python 3 (table-to-diagram)
- Node.js (boxesandarrows)

### Optional
- ImageMagick (PNG conversion via CLI)
- sharp + @resvg/resvg-js (PNG conversion via Node)
- nodemon + live-server (watch mode)
- ai-roadmap tools (PowerPoint generation)

## Extending the System

### Add More Diagrams

1. Create new YAML file
2. Add row to builds.csv
3. Reference in markdown

### Different Diagram Types

The table system supports:
- Conceptual architecture (this example)
- Layered architecture
- Component diagrams
- System context diagrams

Just adjust the nesting structure!

### Custom Styles

Edit `../concept_pack/conceptual-arch-config.yaml`:
```yaml
colors:
  box:
    edge: '1F6FA8'    # Border color
    fill: 'E8F4F8'    # Fill color
    text: '000000'    # Text color
```

### Integration with Other Tools

The system outputs standard formats:
- SVG (can be embedded anywhere)
- PNG (for presentations, documents)
- YAML (can be version controlled)

## Troubleshooting Flow

```
Problem: "Diagram not generating"
  ↓
Check: Python 3 installed?
  ↓
Check: ../concept_pack/table-to-diagram.py exists?
  ↓
Check: ../boxesandarrows exists?
  ↓
Run: ./generate-diagram.sh
  ↓
Check output for specific error
```

```
Problem: "PNG not generating"
  ↓
Install ImageMagick: brew install imagemagick
  OR
Install Node packages: npm install
  AND
Run: node generate-pngs.js
```

```
Problem: "PowerPoint not generating"
  ↓
Check: ../ai-roadmap/build-presentation.js exists?
  ↓
Run from ai-roadmap:
  cd ../ai-roadmap
  node build-presentation.js ../example_concept_pack/example-concept-pack.md
```

## Best Practices

1. **Start with the example** - Customize, don't start from scratch
2. **Use watch mode** - See changes instantly
3. **Keep YAML simple** - Use auto heights/widths where possible
4. **Version control YAML** - Not the generated files
5. **Test incrementally** - Build after each change
6. **Document decisions** - Add comments in YAML
7. **Reuse structures** - Copy working patterns

## Performance

- **Table → Boxes:** ~100ms (Python)
- **Boxes → SVG:** ~200ms (Node.js)
- **SVG → PNG:** ~500ms (ImageMagick or Node)
- **Full build:** ~1 second

Watch mode rebuilds on save (1-2 seconds including browser refresh).

## Version Control

**Commit:**
- YAML architecture files
- Markdown presentation files
- Configuration files
- Scripts

**Don't commit:**
- output/ directory
- Generated positioned YAML
- node_modules/
- PNG cache

See `.gitignore` for complete list.

## Questions?

This is a working example. Copy it, customize it, make it your own!

For issues with specific components, see:
- Table diagrams: `../concept_pack/README.md`
- BoxWatcher: `../boxwatcher/README.md`
- BoxesAndArrows: `../boxesandarrows/README.md`
- Presentations: `../ai-roadmap/README.md`
