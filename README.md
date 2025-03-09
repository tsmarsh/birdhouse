# Parametric Scandinavian Birdhouse

A minimalist, modern birdhouse design with a clean Scandinavian aesthetic, inspired by Teenage Engineering and IKEA design principles. This parametric OpenSCAD model allows for easy customization to accommodate various bird species.

## Features

- Fully parametric design (adjust for different bird species)
- Minimalist Scandinavian aesthetic
- Removable roof for easy cleaning
- Integrated drainage system
- Optional ventilation holes
- Interior texture for fledglings
- Cross-section analysis capability
- Mounting hole for easy installation

## Bird Species Presets

The model includes presets for common cavity-nesting birds:

| Bird Type | Interior Dimensions | Entrance Hole | Target Species |
|-----------|---------------------|---------------|----------------|
| Small     | 100 x 100 x 150mm   | 32mm          | Chickadees, Nuthatches, Titmice |
| Medium    | 130 x 130 x 170mm   | 38mm          | Bluebirds, Tree Swallows |
| Large     | 175 x 175 x 300mm   | 60mm          | Woodpeckers, Small Owls |

## Customization Parameters

### Basic Settings
- `width`, `depth`, `height`: Interior dimensions
- `door_od`: Entrance hole diameter
- `wall_thickness`: Wall thickness
- `drain_od`: Drainage hole diameter

### Advanced Settings
- `door_height_factor`: Entrance hole height (as proportion of total height)
- `drain_holes`: Number of drainage holes
- `add_ventilation`: Toggle ventilation holes
- `add_interior_texture`: Toggle interior texture for bird grip

### Cross-Section Analysis
- `enable_cross_section`: Toggle cross-section view
- `cross_section_type`: Type of cross-section (horizontal, vertical)
- `cross_section_position`: Position of the cross-section
- `cross_section_thickness`: Thickness of cross-section slice

## Printing Recommendations

- **Material**: PETG or ASA recommended for outdoor use
- **Infill**: 15-20%
- **Layer Height**: 0.2mm works well
- **Supports**: Not required for most printers
- **Print Orientation**: Print the base with the bottom on the build plate, and the roof with the top surface on the build plate

## Installation Tips

1. Mount 5-8 feet high on a post or tree
2. Face entrance hole away from prevailing winds
3. Position with morning sun exposure
4. No need to add a perch (birds don't need them, and they help predators)
5. Clean annually in late winter before nesting season

## Usage

### Basic Usage
1. Open the .scad file in OpenSCAD
2. Adjust parameters as needed using the Customizer
3. Render and export STL files for the base and roof

### Cross-Section Analysis
1. Set `enable_cross_section = true`
2. Choose cross-section type and position
3. Render to see the cross-section view
4. For 2D projections, use the `cross_section_projection()` function

## License

This design is licensed under CC-BY-4.0. Feel free to modify and share, but please provide attribution.

## Acknowledgments

- Inspired by Scandinavian design principles
- Design based on ornithological research for optimal bird housing
- Special thanks to the OpenSCAD community

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
