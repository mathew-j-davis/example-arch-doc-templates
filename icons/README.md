# Abstract Geometric Icons

This folder contains 30 abstract geometric icons used in the architecture diagrams.

## Usage

Icons are automatically assigned randomly to cells in the diagram when you generate the architecture diagram. The table-to-diagram.py script automatically detects icons in this folder and adds them to cells.

## Icons

All icons are white outline SVG files on transparent backgrounds, designed to work well in diagram cells.

### Basic Shapes
- icon-001-circle.svg - Simple circle
- icon-002-square.svg - Simple square  
- icon-003-triangle.svg - Upright triangle
- icon-004-diamond.svg - Rotated square

### Combined Shapes
- icon-005-circle-square.svg - Circle with centered square
- icon-006-triangle-circle.svg - Triangle with centered circle
- icon-007-diamond-circle.svg - Diamond with centered circle
- icon-009-layered-shapes.svg - Hexagon and square nested
- icon-014-star.svg - Square and diamond overlay (8-pointed star)
- icon-015-triangle-square.svg - Triangle with centered square
- icon-018-square-diamond.svg - Square with small centered diamond
- icon-025-ring.svg - Circle containing a diamond

### Concentric Patterns
- icon-008-concentric-circles.svg - Three nested circles
- icon-022-nested-squares.svg - Three concentric squares
- icon-030-nested-diamonds.svg - Three concentric diamonds

### Line-Based
- icon-010-x.svg - Diagonal cross
- icon-011-circle-cross.svg - Circle with cross inside
- icon-012-square-cross.svg - Square with horizontal line
- icon-020-chevron-up.svg - Upward pointing chevron
- icon-028-diagonal-line.svg - Diagonal line with triangle
- icon-029-asterisk.svg - Eight-pointed star (cross + X)

### Polygons
- icon-013-hexagon.svg - Six-sided polygon
- icon-019-octagon.svg - Eight-sided polygon
- icon-021-pentagon.svg - Five-sided polygon

### Circular Arrangements
- icon-016-overlapping-circles.svg - Two circles side by side
- icon-017-triple-circles.svg - Three circles in triangular arrangement

### Special Shapes
- icon-023-triangle-inverted.svg - Downward pointing triangle
- icon-024-double-triangle.svg - Two triangles side by side
- icon-026-semicircle.svg - Half circle with base
- icon-027-quarter-circle.svg - Quarter circle segment

## Specifications

- **Format**: SVG
- **Size**: 512×512 viewBox
- **Style**: White outline (`stroke="white"`)
- **Stroke Width**: 8px (consistent across all icons)
- **Fill**: None (transparent)
- **Icon Size in Diagram**: 1.5cm × 1.5cm
- **Position**: Top center of cell with 0.3cm offset from top

## Customization

To change icon colors, edit the `stroke="white"` attribute in any SVG file.

To adjust icon size or position in diagrams, modify the `svg_icon_w`, `svg_icon_h`, `svg_icon_anchor`, and `svg_icon_y_offset` values in the table-to-diagram.py script.
