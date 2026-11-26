# Example Concept Pack - Architecture & Design Principles

## Design Principle: Clean Separation

This example demonstrates the **clean separation** between reusable tools and project-specific configuration:

### Reusable Tools (Never Modified)
- **../boxesandarrows/** - Core SVG rendering engine
- **../boxwatcher/** - Build automation and watch system
- **../concept_pack/table-to-diagram.py** - Table layout generator
- **../ai-roadmap/** - Presentation builder

### Project-Specific (All in example_concept_pack/)
- **Configuration files**
- **Diagram definitions (YAML)**
- **Markdown content**
- **Generated outputs**
- **Intermediate files**
- **Local scripts**

## Directory Structure

```
example_concept_pack/              # THIS PROJECT
├── boxwatcher.config.json         # Points to ../boxwatcher
├── diagram-definitions/
│   ├── example-architecture.yaml  # YOUR diagram definition
│   ├── builds.csv                 # Build configuration
│   ├── png-config.json           # PNG settings
│   └── diagram-config.yaml       # Optional local config
├── output/                        # Generated files
│   ├── architecture.svg          # SVG output
│   └── architecture.png          # PNG export
├── generate-diagram.sh           # Local helper script
├── build-all.sh                  # Local build script
└── example-concept-pack.md       # Presentation content

../boxesandarrows/                 # SHARED TOOL (clean)
../boxwatcher/                     # SHARED TOOL (clean)
../concept_pack/                   # SHARED TOOL (clean)
├── table-to-diagram.py           # Generator script
└── conceptual-arch-config.yaml   # Default config (not modified)
```

## Configuration Strategy

### 1. Tool Location (boxwatcher.config.json)
```json
{
  "boxesandarrows": {
    "path": "../boxesandarrows"  // Where to find the tool
  }
}
```

**Purpose:** Tell this project where the shared tools are

**Strategy:** Relative paths from project root

### 2. Diagram Style (diagram-config.yaml - optional)
```yaml
colors:
  box:
    edge: '1F6FA8'
    fill: 'E8F4F8'
```

**Purpose:** Override default styles for this project

**Strategy:** Falls back to concept_pack defaults if not provided

### 3. Build Configuration (builds.csv)
```csv
name,command,enabled
architecture,<full command chain>,true
```

**Purpose:** Define what to build for this project

**Strategy:** Commands reference shared tools but execute in project context

### 4. PNG Settings (png-config.json)
```json
{
  "diagrams": {
    "architecture": { "scale": 2 }
  }
}
```

**Purpose:** Per-diagram PNG export settings

**Strategy:** Project-specific output requirements

## Data Flow

### Input (Your Edits)
```
diagram-definitions/example-architecture.yaml  # Edit this
example-concept-pack.md                        # Edit this
```

### Processing (Uses Shared Tools)
```
example-architecture.yaml
    ↓ [table-to-diagram.py from ../concept_pack]
example-architecture-positioned.yaml  # Interim (stays here)
    ↓ [../boxesandarrows]
architecture.svg  # Output (stays here)
    ↓ [PNG converter]
architecture.png  # Output (stays here)
```

### Output (All Local)
```
output/architecture.svg
output/architecture.png
output-powerpoint/example-concept-pack.pptx
diagram-definitions/example-architecture-positioned.yaml
```

## Why This Matters

### For Reusable Tools
✅ Clean - no project-specific clutter
✅ Versioned separately
✅ Can be updated without affecting projects
✅ Single source of truth for logic

### For Projects
✅ Self-contained - all config and outputs here
✅ Easy to version control (git add this folder)
✅ Easy to share (copy this folder)
✅ No risk of breaking shared tools

### For Multiple Projects
```
boxes/
├── boxesandarrows/           # Shared
├── boxwatcher/               # Shared
├── concept_pack/             # Shared
├── example_concept_pack/     # Project 1
├── my-system-architecture/   # Project 2
├── customer-presentation/    # Project 3
└── internal-docs/            # Project 4
```

Each project is independent but uses the same tools!

## Copying This Example

### To create a new project:

```bash
# 1. Copy the entire example folder
cp -r example_concept_pack my-new-project

# 2. Update the name in files
# - package.json: change "name"
# - example-concept-pack.md: rename file
# - README.md: update title

# 3. Customize content
# - diagram-definitions/example-architecture.yaml
# - your-presentation.md

# 4. Build
cd my-new-project
./generate-diagram.sh
```

The shared tools don't need any changes!

## Configuration Hierarchy

### 1. Tool Defaults
**Location:** In the tool itself (e.g., ../concept_pack/conceptual-arch-config.yaml)

**Applies to:** All projects using the tool

**When to change:** Never (unless you want to change the tool itself)

### 2. Project Config
**Location:** In your project (e.g., diagram-definitions/diagram-config.yaml)

**Applies to:** Only this project

**When to change:** When you want project-specific styling

### 3. Build Config
**Location:** builds.csv, png-config.json

**Applies to:** Build process for this project

**When to change:** When you want to change what gets built or how

## Common Patterns

### Pattern 1: Use Defaults
```bash
# No local config needed
# Uses ../concept_pack/conceptual-arch-config.yaml
./generate-diagram.sh
```

**Best for:** Most projects

### Pattern 2: Override Colors
```yaml
# diagram-definitions/diagram-config.yaml
colors:
  box:
    edge: 'FF6B6B'  # Red theme
    fill: 'FFE5E5'
```

**Best for:** Branded presentations

### Pattern 3: Multiple Diagrams
```csv
# builds.csv
architecture,<command1>,true
data-flow,<command2>,true
deployment,<command3>,true
```

**Best for:** Complex documentation

## Maintenance

### Updating Shared Tools
```bash
# Update boxwatcher
cd ../boxwatcher
git pull

# Update boxesandarrows
cd ../boxesandarrows
git pull
```

Your project continues to work - no changes needed!

### Updating Project
```bash
# Change content
vim diagram-definitions/example-architecture.yaml

# Rebuild
./generate-diagram.sh
```

Shared tools remain unchanged!

## Version Control Best Practices

### Commit to Project Repo
```
✅ diagram-definitions/*.yaml (source)
✅ *.md (source)
✅ *.sh (scripts)
✅ *.json (config)
✅ README.md (docs)
❌ output/ (generated)
❌ *-positioned.yaml (intermediate)
❌ node_modules/ (dependencies)
```

### Commit to Tool Repos
```
✅ Core logic files
✅ Default configs
✅ Documentation
✅ Examples (if part of tool)
❌ Project-specific anything
```

## Extension Points

### Want to customize colors?
→ Create `diagram-definitions/diagram-config.yaml`

### Want different output location?
→ Update `boxwatcher.config.json` paths

### Want multiple diagrams?
→ Add rows to `builds.csv`

### Want different PowerPoint theme?
→ Customize in ai-roadmap (not here - affects all projects)

### Want different table generator?
→ Extend concept_pack (not here - new feature for all)

## Philosophy

**Tool repos:** Features and fixes that benefit everyone

**Project repos:** Content and configuration specific to one use case

**Result:** Maximum reusability + maximum flexibility

## Questions?

This architecture makes it easy to:
1. Maintain tools independently
2. Create new projects quickly
3. Share projects without dependencies
4. Upgrade tools without breaking projects

It's the right way to organize a tool ecosystem!
