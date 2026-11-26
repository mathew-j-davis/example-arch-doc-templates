# File Index - What Each File Does

## 📖 Documentation (Read These!)

| File | Purpose |
|------|---------|
| **README.md** | Complete documentation - start here |
| **QUICKSTART.md** | 5-minute quick start guide |
| **ARCHITECTURE.md** | Explains clean separation and design principles |
| **SYSTEM-OVERVIEW.md** | Deep dive into how all pieces fit together |
| **INDEX.md** | This file - quick reference |

## 🎨 Source Files (Edit These!)

| File | Purpose |
|------|---------|
| **diagram-definitions/example-architecture.yaml** | Your architecture diagram definition |
| **example-concept-pack.md** | Your presentation content |

## ⚙️ Configuration Files

| File | Purpose | Required? |
|------|---------|-----------|
| **boxwatcher.config.json** | Points to shared tools | Yes |
| **diagram-definitions/builds.csv** | What to build | Yes |
| **diagram-definitions/png-config.json** | PNG export settings | Optional |
| **diagram-definitions/diagram-config.yaml** | Style overrides | Optional |
| **package.json** | Node dependencies | Yes if using boxwatcher |

## 🔧 Helper Scripts (Run These!)

| File | Command | What It Does |
|------|---------|--------------|
| **generate-diagram.sh** | `./generate-diagram.sh` | Generate SVG + PNG |
| **build-all.sh** | `./build-all.sh` | Generate everything (diagram + PowerPoint) |
| **setup-boxwatcher.sh** | `./setup-boxwatcher.sh` | Copy boxwatcher files (one-time) |
| **watch-and-serve.sh** | `./watch-and-serve.sh` | Watch mode + live-reload (after setup) |

## 📁 Generated Files (Don't Edit!)

| Location | What's There |
|----------|--------------|
| **output/architecture.svg** | Generated diagram (SVG) |
| **output/architecture.png** | Generated diagram (PNG) |
| **diagram-definitions/example-architecture-positioned.yaml** | Intermediate file (positioned boxes) |
| **output-powerpoint/example-concept-pack.pptx** | Generated PowerPoint (after build-all) |

## 🗂️ Directories

| Directory | Purpose |
|-----------|---------|
| **diagram-definitions/** | All diagram source files and configs |
| **output/** | All generated output files |
| **assets/** | Any additional assets you want to include |

## 🚀 Quick Reference

### First Time Setup
```bash
./generate-diagram.sh          # Generate the example
open output/architecture.svg   # View it
```

### Make Your Own
```bash
# 1. Edit the architecture
vim diagram-definitions/example-architecture.yaml

# 2. Edit the presentation
vim example-concept-pack.md

# 3. Regenerate
./build-all.sh
```

### Watch Mode (Optional)
```bash
./setup-boxwatcher.sh   # One-time setup
npm install             # Install dependencies
./watch-and-serve.sh    # Start watching
```

## 📋 Checklist for New Projects

When copying this example:

- [ ] Copy entire folder
- [ ] Rename `example-concept-pack.md` to your project name
- [ ] Update `package.json` name field
- [ ] Edit `diagram-definitions/example-architecture.yaml`
- [ ] Edit your `.md` file with your content
- [ ] Run `./generate-diagram.sh` to test
- [ ] Add to version control (git)
- [ ] Run `./build-all.sh` to generate everything

## 🔍 Finding Things

**Where is the architecture defined?**
→ `diagram-definitions/example-architecture.yaml`

**Where are the colors configured?**
→ `diagram-definitions/diagram-config.yaml` (optional, falls back to concept_pack defaults)

**Where does the diagram get built?**
→ `output/`

**Where are the intermediate files?**
→ `diagram-definitions/*-positioned.yaml`

**Where is the PowerPoint config?**
→ Not here! PowerPoint generation is configured in `../ai-roadmap/`

**Where are the boxwatcher tools?**
→ Not here! They're in `../boxwatcher/` - this project just references them

## ⚡ Common Tasks

### Change a label
Edit `diagram-definitions/example-architecture.yaml`, find the label, change it, run `./generate-diagram.sh`

### Change colors
Create or edit `diagram-definitions/diagram-config.yaml`, add color overrides, run `./generate-diagram.sh`

### Add a slide
Edit `example-concept-pack.md`, add new slide section, run `./build-all.sh`

### Add another diagram
1. Create new `.yaml` file
2. Add row to `builds.csv`
3. Run `./build-all.sh`

### Generate only SVG (no PNG)
Set `"enabled": false` in `diagram-definitions/png-config.json`

### Generate only PowerPoint (no diagram)
Skip the diagram generation, run PowerPoint builder directly from ai-roadmap

## 🎯 Remember

**Source files** (edit these):
- `diagram-definitions/example-architecture.yaml`
- `example-concept-pack.md`

**Output files** (generated, don't edit):
- `output/*`
- `*-positioned.yaml`

**Shared tools** (never modify):
- `../boxesandarrows/`
- `../boxwatcher/`
- `../concept_pack/`

Everything else is configuration!
