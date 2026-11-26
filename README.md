# Example Concept Pack

Complete working example of the concept pack system - from YAML architecture diagrams to PowerPoint presentations.

## What's Included

This example demonstrates:

1. **Table-based architecture diagrams** - Clean YAML definition
2. **BoxWatcher integration** - Auto-rebuild and serve diagrams
3. **PNG generation** - High-quality exports for presentations
4. **PowerPoint generation** - From markdown to slides

## Quick Start

### 1. Generate the diagram

```bash
chmod +x generate-diagram.sh
./generate-diagram.sh
```

This will create:
- `output/architecture.svg` - Scalable vector diagram
- `output/architecture.png` - High-res PNG for PowerPoint

### 2. View the diagram

Open `output/architecture.svg` in a browser or:

```bash
# Set up boxwatcher (first time only)
chmod +x setup-boxwatcher.sh
./setup-boxwatcher.sh
npm install

# Install global tools
npm install -g nodemon live-server

# Start watch mode with live-reload
./watch-and-serve.sh
```

Then edit `diagram-definitions/example-architecture.yaml` and see changes instantly!

### 3. Generate PowerPoint

**Using ai-roadmap's system:**

```bash
# From ai-roadmap directory
cd ../ai-roadmap
node build-presentation.js ../example_concept_pack/example-concept-pack.md
```

This creates `output-powerpoint/example-concept-pack.pptx` with:
- Title slides
- Content slides
- Architecture diagram (slide 3)
- Professional formatting

## File Structure

```
example_concept_pack/
├── README.md                           # This file
├── example-concept-pack.md            # Markdown source for presentation
├── generate-diagram.sh                # Quick diagram generation
├── setup-boxwatcher.sh                # One-time boxwatcher setup
├── boxwatcher.config.json             # BoxWatcher configuration
│
├── diagram-definitions/
│   ├── example-architecture.yaml      # Table-based architecture
│   ├── builds.csv                     # BoxWatcher builds
│   └── png-config.json               # PNG generation settings
│
├── output/
│   ├── architecture.svg              # Generated diagram
│   └── architecture.png              # PNG export
│
└── assets/                           # Any additional assets
```

## Customizing the Architecture

Edit `diagram-definitions/example-architecture.yaml`:

```yaml
table:
  width: 46.6
  height: 40.0
  rows:
    - height: auto
      columns:
        # Left sidebar
        - width: 8.0
          cells_stack:
            - label: "USERS"
              type: header
            - label: "Your users..."
              
        # Center layers
        - width: 30.2
          table:
            rows:
              - height: auto
                columns:
                  - width: 8.0
                    cell:
                      label: "LAYER NAME"
                      type: header
                  - width: 22.0
                    table:
                      rows:
                        - height: auto
                          columns:
                            - cell:
                                label: "Component 1"
                            - cell:
                                label: "Component 2"
```

### Key concepts:

**`cells_stack`** - Simple vertical stack:
```yaml
cells_stack:
  - label: "Header"
    type: header
    height: 2.0
  - label: "Item 1"
    height: auto
  - label: "Item 2"
    height: auto
```

**`table`** - Nested rows and columns for 2D layouts:
```yaml
table:
  rows:
    - height: auto
      columns:
        - width: 8.0
          cell: { label: "Label" }
        - width: auto
          table:
            rows: [...]  # More nesting
```

**Types for styling:**
- `header` - Blue header style
- `foundation` - Light blue
- `cross_cutting` - Blue bar
- (default) - Standard box

## Customizing the Presentation

Edit `example-concept-pack.md`:

```markdown
# Your Title
slide-type:: title-slide
title:: Your Presentation
subtitle:: Your Subtitle

---

# Content Slide
slide-type:: content-slide
title:: Slide Title

Your content here...

---

# Architecture Diagram
slide-type:: image-slide
title:: System Architecture
image:: output/architecture.png

---
```

### Slide types:
- `title-slide` - Title/cover slide
- `content-slide` - Text content with bullets
- `image-slide` - Full-size image with title

## BoxWatcher Commands

Once set up with `./setup-boxwatcher.sh`:

**Build once:**
```bash
node build-all.js
```

**Watch mode:**
```bash
./watch-and-serve.sh
```

**Just serve (no watch):**
```bash
live-server output --port=8080
```

## Dependencies

### Required
- Node.js (for boxesandarrows)
- Python 3 (for table-to-diagram)

### For PNG generation
PNG generation uses BoxWatcher's existing logic (no ImageMagick needed):
```bash
npm install  # Installs sharp and @resvg/resvg-js
```

That's it! No copying of tool files needed.

### For watch mode (optional)
```bash
npm install -g nodemon live-server
```

### For PNG generation in Node (alternative to ImageMagick)
```bash
npm install
# Installs sharp and @resvg/resvg-js
```

## Troubleshooting

### "Command not found: python3"
Make sure Python 3 is installed:
```bash
python3 --version
```

### "table-to-diagram.py not found"
Make sure you're running from the example_concept_pack directory and that ../concept_pack exists.

### "boxesandarrows not found"
Check that ../boxesandarrows exists, or update the path in `boxwatcher.config.json`.

### PNG not generating
Run setup and install dependencies:
```bash
./setup-boxwatcher.sh   # Copy BoxWatcher tools
npm install             # Install sharp and @resvg/resvg-js
./generate-diagram.sh   # Regenerate
```

No ImageMagick needed - uses BoxWatcher's existing PNG generation logic!

### PowerPoint not generating
You need the presentation builder from ai-roadmap. See the ai-roadmap README for setup.

## Tips

1. **Start simple** - Copy this example, customize the labels
2. **Use auto heights** - Let the system calculate proportions
3. **Fixed widths** - Sidebars work best with fixed widths (8.0cm)
4. **Center flexibility** - Use auto widths for center content
5. **Test iteratively** - Use watch mode to see changes live

## Example Architectures

### Microservices
```yaml
# Users | Presentation | API Gateway | External
#       | Services     | Service Mesh |
#       | Data         | Message Queue |
```

### Three-tier
```yaml
# Users | Frontend | External
#       | Backend  |
#       | Database |
```

### Event-driven
```yaml
# Producers | Event Bus | Consumers | External
#           | Storage   | Analytics |
```

Just copy the structure and customize the labels!

## Related Documentation

- **concept_pack/** - Table diagram generator
- **boxwatcher/** - Diagram build system
- **ai-roadmap/** - PowerPoint generation
- **boxesandarrows/** - Core SVG rendering

## License

MIT

## Questions?

This is an example project. Customize it for your needs!
