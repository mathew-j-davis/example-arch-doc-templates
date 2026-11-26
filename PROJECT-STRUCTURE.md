# Project Structure - Clean Separation

This project demonstrates the **clean separation** principle: reusable tools stay clean, project contains only definitions, outputs, and config.

## What's in This Project

### 📄 Documentation (6 files)
```
ARCHITECTURE.md        - Design principles and clean separation
INDEX.md              - Quick reference of what each file does
PROJECT-STRUCTURE.md  - This file
QUICKSTART.md         - 5-minute start guide
README.md             - Complete documentation
SYSTEM-OVERVIEW.md    - Deep dive into the system
```

### 🎨 Content & Definitions
```
example-concept-pack.md                     - Presentation content (9 slides)
diagram-definitions/
  ├── example-architecture.yaml             - Architecture diagram definition
  ├── builds.csv                            - Build configuration
  ├── png-config.json                      - PNG export settings
  └── diagram-config.yaml                   - Custom styles (optional)
```

### ⚙️ Project Configuration
```
boxwatcher.config.json  - Points to shared tools (../boxwatcher, ../boxesandarrows, ../concept_pack)
package.json            - Project dependencies (sharp, @resvg/resvg-js)
```

### 🔧 Project Helper Scripts (Ultra-Thin Wrappers)
```
generate-diagram.sh  - Calls: ../concept_pack/build-diagram.sh with this project's paths
build-all.sh         - Calls: generate-diagram.sh + ../concept_pack/build-presentation.sh
watch.sh             - Calls: ../boxwatcher/watch-and-serve.sh
```

**Key:** These scripts only pass parameters - ALL logic is in the tool directories!

### 📦 Generated Output
```
output/
  ├── architecture.svg                      - Generated diagram (SVG)
  └── architecture.png                      - Generated diagram (PNG)
diagram-definitions/
  └── example-architecture-positioned.yaml  - Intermediate file
```

### 🚫 What's NOT Here (By Design)

**NO tool code:**
- ❌ No BoxWatcher scripts (build-all.js, generate-pngs.js, etc.)
- ❌ No concept_pack scripts
- ❌ No boxesandarrows code

**Tools stay in their directories:**
- ../boxwatcher/
- ../concept_pack/
- ../boxesandarrows/
- ../ai-roadmap/

## File Count Summary

| Category | Count | Examples |
|----------|-------|----------|
| Documentation | 6 | README.md, QUICKSTART.md, ... |
| Content/Definitions | 5 | example-architecture.yaml, example-concept-pack.md, ... |
| Config | 2 | boxwatcher.config.json, package.json |
| Helper Scripts | 3 | generate-diagram.sh, build-all.sh, watch.sh |
| **TOTAL** | **16** | (plus generated outputs) |

**No tool code copied = Clean project!**

## How Scripts Call Tools

### New Architecture: Maximum Separation

**All logic lives in tool directories!** Project scripts only pass parameters.

### generate-diagram.sh (Ultra-thin wrapper)
```bash
# Just passes this project's paths to concept_pack
../concept_pack/build-diagram.sh \
  ./diagram-definitions/example-architecture.yaml \
  architecture \
  .
```

**Result:** 4 lines! All logic in concept_pack/build-diagram.sh

### build-all.sh (Ultra-thin wrapper)
```bash
# Calls diagram + presentation builds with parameters
./generate-diagram.sh
../concept_pack/build-presentation.sh \
  ./example-concept-pack.md \
  .
```

**Result:** 6 lines! All logic in concept_pack scripts

### watch.sh (Ultra-thin wrapper)
```bash
# Just calls BoxWatcher from this directory
exec ../boxwatcher/watch-and-serve.sh
```

**Result:** 1 line! BoxWatcher reads our config

### concept_pack/build-diagram.sh (The real logic)
```bash
# This is where the work happens:
# 1. python3 table-to-diagram.py
# 2. node boxesandarrows/src/index.js
# 3. node boxwatcher/generate-pngs.js
```

**Result:** Reusable by any project!

## Dependencies

### Project Dependencies (package.json)
```json
{
  "dependencies": {
    "@resvg/resvg-js": "^2.6.2",  // For PNG generation
    "sharp": "^0.35.5"             // For PNG generation
  },
  "devDependencies": {
    "live-server": "^1.2.2",       // For watch mode
    "nodemon": "^3.0.1"            // For watch mode
  }
}
```

**Why here?** PNG generation needs these packages, and they need to be found when BoxWatcher's code runs.

**How it works:** `NODE_PATH` tells Node.js to look in our `node_modules/`

## Clean Separation Benefits

### For This Project ✅
- Self-contained: all content and config here
- Version controllable: just this directory
- Shareable: copy this folder
- No tool code clutter

### For The Tools ✅
- Clean: no project-specific anything
- Reusable: used by multiple projects
- Versioned separately
- Single source of truth

### For New Projects ✅
```bash
# Copy the example
cp -r example_concept_pack my-project

# Customize content
vim my-project/diagram-definitions/my-architecture.yaml
vim my-project/my-presentation.md

# Build (uses same tools!)
cd my-project
./generate-diagram.sh
```

## Comparison: Before vs After

### Before (Messy)
```
example_concept_pack/
├── build-all.js          ❌ Copied from boxwatcher
├── config.js             ❌ Copied from boxwatcher
├── generate-pngs.js      ❌ Copied from boxwatcher
├── generate-manifest.js  ❌ Copied from boxwatcher
├── watch-and-serve.sh    ❌ Copied from boxwatcher
├── setup-boxwatcher.sh   ❌ Installation script
├── ... (content files)
```

### After (Clean)
```
example_concept_pack/
├── generate-diagram.sh   ✅ Thin wrapper (calls tools)
├── build-all.sh          ✅ Thin wrapper (calls tools)
├── watch.sh              ✅ Thin wrapper (calls tools)
├── example-concept-pack.md         ✅ Content
├── diagram-definitions/            ✅ Definitions
├── boxwatcher.config.json          ✅ Config
└── package.json                    ✅ Dependencies
```

**Result:** 16 files instead of 20+, and NO duplicated code!

## Common Questions

**Q: Why install packages here if tools are elsewhere?**
A: Node.js module resolution. We use `NODE_PATH` to share our packages with BoxWatcher's code.

**Q: Can I delete node_modules/?**
A: Yes, but PNG generation won't work. Run `npm install` to get it back.

**Q: Do I need to set up BoxWatcher?**
A: No! Just have it available at `../boxwatcher/` and call it.

**Q: What if I want different BoxWatcher behavior?**
A: Edit `boxwatcher.config.json` or `builds.csv` - both are project-specific!

**Q: Can other projects use the same tools?**
A: Yes! That's the whole point. Each project has its own content/config, shared tools.

## Verification

To verify your project is clean:

```bash
# Should NOT find any of these:
find . -name "build-all.js" -o -name "generate-pngs.js" -o -name "config.js"
# (should return nothing if clean)

# Should find these:
ls generate-diagram.sh build-all.sh watch.sh
# (should list all three)
```

## Summary

✅ **Clean tools** - no project clutter
✅ **Clean project** - no tool duplication  
✅ **Calls, not copies** - thin wrappers
✅ **Dependencies** - only what's needed for PNG generation
✅ **Self-contained** - all content and config here
✅ **Reusable** - same tools for all projects

**This is the right way to structure a tool ecosystem!**
