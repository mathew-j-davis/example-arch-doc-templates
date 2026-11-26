# Tool Paths Configuration

This project uses a configuration file to manage paths to the diagram generation tools, making it easy to adapt to different directory structures.

## Configuration File

**`diagram-tools.config.yaml`** - Configure paths to external tools:

```yaml
# Path to boxesandarrows repository
boxesandarrows_path: ../boxesandarrows

# Path to concept_pack repository
concept_pack_path: ../concept_pack

# Path to boxwatcher repository
boxwatcher_path: ../boxwatcher
```

## Default Layout

The default configuration assumes this structure:

```
diagram-tools/
├── boxesandarrows/
├── concept_pack/
├── boxwatcher/
└── my-project/              # Your project
    └── diagram-tools.config.yaml
```

## Alternative Layouts

### Tools in a Subdirectory

```
workspace/
├── tools/
│   ├── boxesandarrows/
│   ├── concept_pack/
│   └── boxwatcher/
└── my-project/
```

**Config:**
```yaml
boxesandarrows_path: ../tools/boxesandarrows
concept_pack_path: ../tools/concept_pack
boxwatcher_path: ../tools/boxwatcher
```

### Tools Installed Globally

```
/usr/local/lib/
├── boxesandarrows/
├── concept_pack/
└── boxwatcher/

~/projects/my-project/
```

**Config:**
```yaml
boxesandarrows_path: /usr/local/lib/boxesandarrows
concept_pack_path: /usr/local/lib/concept_pack
boxwatcher_path: /usr/local/lib/boxwatcher
```

## Using the Configuration

### In Bash Scripts

Scripts automatically load paths using `load-tool-paths.sh`:

```bash
#!/bin/bash
source "$(dirname "${BASH_SOURCE[0]}")/load-tool-paths.sh"

# Now use the variables:
# $BOXESANDARROWS_PATH
# $CONCEPT_PACK_PATH
# $BOXWATCHER_PATH

"$CONCEPT_PACK_PATH/table-to-diagram.py" input.yaml output.yaml
```

### In Node.js Scripts

Use the `load-tool-paths.js` module:

```javascript
const { loadToolPaths } = require('./load-tool-paths');

const paths = loadToolPaths();

// paths.boxesandarrows
// paths.concept_pack
// paths.boxwatcher

console.log(paths.boxesandarrows);
```

### In Build Commands

For `diagram-definitions/builds.csv`, use shell script wrappers that source the config:

```csv
name,command
architecture,./build-architecture.sh
```

Then create `build-architecture.sh`:
```bash
#!/bin/bash
source "$(dirname "${BASH_SOURCE[0]}")/../load-tool-paths.sh"

python3 "$CONCEPT_PACK_PATH/table-to-diagram.py" \
  diagram-definitions/example-architecture.yaml \
  output/architecture-positioned.yaml

node "$BOXESANDARROWS_PATH/src/index.js" \
  -y output/architecture-positioned.yaml \
  -r svg \
  -o output/architecture
```

## Verifying Configuration

**Check paths in bash:**
```bash
DEBUG=1 source load-tool-paths.sh
```

**Check paths in Node.js:**
```bash
node load-tool-paths.js
```

Output:
```
Tool paths loaded from configuration:

  ✅ boxesandarrows: /path/to/boxesandarrows
  ✅ concept_pack: /path/to/concept_pack
  ✅ boxwatcher: /path/to/boxwatcher
```

## Scripts Using Configuration

These scripts automatically use `diagram-tools.config.yaml`:

- ✅ `generate-diagram.sh` - Diagram generation
- ✅ `generate-presentation.sh` - PowerPoint generation
- ✅ `watch.sh` - Live-reload watch mode

## Troubleshooting

### "Tool not found" errors

1. **Check config file exists:**
   ```bash
   cat diagram-tools.config.yaml
   ```

2. **Verify paths:**
   ```bash
   node load-tool-paths.js
   ```

3. **Check tool directories exist:**
   ```bash
   ls -la ../boxesandarrows
   ls -la ../concept_pack
   ls -la ../boxwatcher
   ```

4. **Update config with correct paths:**
   ```yaml
   # Edit diagram-tools.config.yaml
   boxesandarrows_path: /correct/path/to/boxesandarrows
   ```

### "Config file not found" warnings

The config file should be in your project root. If missing:

```bash
cp diagram-tools.config.yaml.example diagram-tools.config.yaml
# Edit with correct paths
```

### Relative vs Absolute Paths

- **Relative paths** are relative to your project root (where the config file is)
- **Absolute paths** start with `/` and work from anywhere
- Both are supported and converted to absolute paths internally

## Best Practices

1. **Keep config in project root** - Makes it easy to find and edit
2. **Use relative paths when possible** - More portable across systems
3. **Don't commit personal paths** - Add local overrides to `.gitignore` if needed
4. **Document your layout** - Add comments to config file showing your structure

## Example: Multiple Projects

If you have multiple diagram projects sharing the same tools:

```
workspace/
├── diagram-tools/
│   ├── boxesandarrows/
│   ├── concept_pack/
│   └── boxwatcher/
├── project-a/
│   └── diagram-tools.config.yaml
└── project-b/
    └── diagram-tools.config.yaml
```

Both projects use the same config:
```yaml
boxesandarrows_path: ../diagram-tools/boxesandarrows
concept_pack_path: ../diagram-tools/concept_pack
boxwatcher_path: ../diagram-tools/boxwatcher
```
