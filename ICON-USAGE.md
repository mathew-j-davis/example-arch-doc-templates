# Using Icons in Diagram Cells

## Overview

You can add icons to any cell in your diagram by specifying the `icon` field in the cell definition in your YAML file.

## Syntax

```yaml
- cell:
    label: "My Service"
    icon: "icons/icon-name.svg"
```

## Example

```yaml
table:
  rows:
    - columns:
        - cell:
            label: "Web UI"
            icon: "icons/icon-002-square.svg"
        - cell:
            label: "Mobile App"
            icon: "icons/icon-004-diamond.svg"
        - cell:
            label: "API Gateway"
            icon: "icons/icon-013-hexagon.svg"
```

## Icon Specifications

- **Path**: Relative to the project root (where the YAML file is)
- **Format**: SVG files
- **Size**: Icons are rendered at 1.5cm × 1.5cm in the diagram
- **Position**: Top center of the cell with 0.3cm offset from the top edge
- **Style**: White outline works best on colored cell backgrounds

## Available Icons

The `icons/` folder contains 30 abstract geometric icons. See `icons/README.md` for a complete list with descriptions.

### Quick Reference

**Basic Shapes**
- `icon-001-circle.svg` - Circle
- `icon-002-square.svg` - Square
- `icon-003-triangle.svg` - Triangle
- `icon-004-diamond.svg` - Diamond

**Combined Shapes**
- `icon-005-circle-square.svg` - Circle + Square
- `icon-007-diamond-circle.svg` - Diamond + Circle
- `icon-013-hexagon.svg` - Hexagon
- `icon-014-star.svg` - 8-pointed Star
- `icon-019-octagon.svg` - Octagon
- `icon-021-pentagon.svg` - Pentagon

**Concentric Patterns**
- `icon-008-concentric-circles.svg` - Nested circles
- `icon-022-nested-squares.svg` - Nested squares
- `icon-030-nested-diamonds.svg` - Nested diamonds

**And 17 more...**

See the full list in `icons/README.md`

## Tips

1. **Choose meaningful icons**: Pick icons that represent the type of component or service
   - Squares/rectangles for UI components
   - Circles for services
   - Hexagons for APIs
   - Nested shapes for data storage
   - Stars/polygons for platforms

2. **Consistency**: Use similar icon styles for similar types of components

3. **Optional**: Icons are completely optional - cells without an `icon` field will simply not have an icon

4. **Custom icons**: You can add your own SVG icons to the `icons/` folder and reference them the same way

## Example from example-architecture.yaml

```yaml
# Presentation Layer with different icons for each UI type
- cell:
    label: "Web UI"
    icon: "icons/icon-002-square.svg"
- cell:
    label: "Mobile App"
    icon: "icons/icon-004-diamond.svg"
- cell:
    label: "API Gateway"
    icon: "icons/icon-013-hexagon.svg"

# Business Logic with service icons
- cell:
    label: "Order Service"
    icon: "icons/icon-005-circle-square.svg"
- cell:
    label: "User Service"
    icon: "icons/icon-011-circle-cross.svg"

# Data Layer with storage icons
- cell:
    label: "Database"
    icon: "icons/icon-008-concentric-circles.svg"
- cell:
    label: "Cache"
    icon: "icons/icon-025-ring.svg"
```

## Troubleshooting

**Icons not showing up?**
- Check the icon path is correct relative to the project root
- Ensure the SVG file exists in the `icons/` folder
- Regenerate the diagram: `python3 ../concept_pack/table-to-diagram.py diagram-definitions/example-architecture.yaml output/architecture-positioned.yaml`
- Regenerate the SVG: `cd ../boxesandarrows && node src/index.js -y ../example_concept_pack/output/architecture-positioned.yaml -r svg -o ../example_concept_pack/output/diagram`
