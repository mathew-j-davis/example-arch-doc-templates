# Quick Start - 5 Minutes to Your First Diagram

## Fastest Path

```bash
# 1. Generate the example diagram
./generate-diagram.sh

# 2. View it
open output/architecture.svg

# 3. Build everything (diagram + PowerPoint)
./build-all.sh
```

Done! You now have:
- `output/architecture.svg` - Your diagram
- `output/architecture.png` - PNG for presentations
- `output-powerpoint/example-concept-pack.pptx` - Full PowerPoint

## What Just Happened?

The system:
1. Converted `diagram-definitions/example-architecture.yaml` → positioned boxes
2. Rendered positioned boxes → SVG diagram
3. Converted SVG → PNG (if ImageMagick available)
4. Generated PowerPoint from `example-concept-pack.md` (if ai-roadmap available)

## Next: Customize Your Architecture

Edit `diagram-definitions/example-architecture.yaml`:

```yaml
# Change these labels to your system:
- label: "USERS"          # → "STAKEHOLDERS"
- label: "Web UI"         # → "Admin Portal"
- label: "Order Service"  # → "Your Service"
```

Then rebuild:
```bash
./generate-diagram.sh
```

## Optional: Watch Mode

For live-reload while editing:

```bash
# One-time setup
./setup-boxwatcher.sh
npm install
npm install -g nodemon live-server

# Start watching
./watch-and-serve.sh
```

Now edit YAML files and see changes instantly at http://localhost:8080!

## Troubleshooting

**"python3: command not found"**
```bash
# Install Python 3
brew install python3  # macOS
```

**"PNG not generated"**
```bash
# Set up BoxWatcher and install dependencies
./setup-boxwatcher.sh
npm install
./generate-diagram.sh
```

**"PowerPoint not generated"**
```bash
# Set up ai-roadmap first, then:
cd ../ai-roadmap
node build-presentation.js ../example_concept_pack/example-concept-pack.md
```

## Full Documentation

See `README.md` for complete documentation, customization options, and advanced features.
