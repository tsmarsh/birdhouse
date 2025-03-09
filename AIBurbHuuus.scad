// Parametric Scandinavian Birdhouse
// Customizable parameters for different bird species

/* [Bird House Dimensions] */
// Width of the birdhouse (mm)
width = 100;
// Depth of the birdhouse (mm)
depth = 100;
// Height of the birdhouse (mm)
height = 150;
// Entrance hole diameter (mm)
door_od = 32;
// Drainage hole diameter (mm)
drain_od = 4;
// Wall thickness (mm)
wall_thickness = 3;
// Roof thickness as a fraction of width
roof_thickness_factor = 0.1;
// Calculate roof thickness
roof_thickness = width * roof_thickness_factor;

/* [Advanced Options] */
// Height of entrance hole (fraction of total height)
door_height_factor = 0.6;
// Number of drainage holes
drain_holes = 5;
// Add ventilation holes near top
add_ventilation = true;
// Add interior texture for bird grip
add_interior_texture = true;

// Calculated values
corner_radius = roof_thickness * 2;

module external_wall(){
    hull(){
        linear_extrude(height = height){
            // Create rounded corners using circles
            translate([corner_radius, corner_radius, 0]) 
                circle(corner_radius);
            translate([corner_radius, depth - corner_radius, 0]) 
                circle(corner_radius);
            translate([width - corner_radius, corner_radius, 0]) 
                circle(corner_radius);
            translate([width - corner_radius, depth - corner_radius, 0]) 
                circle(corner_radius);
        }
    }
}

module internal_wall() {
    w = width - wall_thickness * 2;
    d = depth - wall_thickness * 2;
    
    translate([wall_thickness, wall_thickness, wall_thickness])
    linear_extrude(height = height){
        hull(){
            translate([corner_radius, corner_radius, 0]) 
                circle(corner_radius);
            translate([corner_radius, d - corner_radius, 0]) 
                circle(corner_radius);
            translate([w - corner_radius, corner_radius, 0]) 
                circle(corner_radius);
            translate([w - corner_radius, d - corner_radius, 0]) 
                circle(corner_radius);
        }
    }
}

module drain() {
    // Create drainage holes pattern
    if (drain_holes == 1) {
        // Just center hole
        translate([width / 2, depth / 2, -2])
        linear_extrude(wall_thickness * 2) {
            circle(drain_od);
        }
    } else if (drain_holes <= 5) {
        // Center plus cardinal points
        offset = drain_od * 4;
        
        // Center hole
        translate([width / 2, depth / 2, -2])
        linear_extrude(wall_thickness * 2) {
            circle(drain_od);
        }
        
        if (drain_holes > 1) {
            // North hole
            translate([width / 2, depth / 2 + offset, -2])
            linear_extrude(wall_thickness * 2) {
                circle(drain_od);
            }
        }
        
        if (drain_holes > 2) {
            // South hole
            translate([width / 2, depth / 2 - offset, -2])
            linear_extrude(wall_thickness * 2) {
                circle(drain_od);
            }
        }
        
        if (drain_holes > 3) {
            // East hole
            translate([width / 2 + offset, depth / 2, -2])
            linear_extrude(wall_thickness * 2) {
                circle(drain_od);
            }
        }
        
        if (drain_holes > 4) {
            // West hole
            translate([width / 2 - offset, depth / 2, -2])
            linear_extrude(wall_thickness * 2) {
                circle(drain_od);
            }
        }
    } else {
        // Create a circular pattern for more holes
        radius = min(width, depth) / 3;
        for (i = [0 : drain_holes - 1]) {
            angle = i * 360 / drain_holes;
            translate([
                width / 2 + radius * cos(angle), 
                depth / 2 + radius * sin(angle), 
                -2
            ])
            linear_extrude(wall_thickness * 2) {
                circle(drain_od);
            }
        }
    }
}

module ventilation_holes() {
    if (add_ventilation) {
        vent_size = drain_od;
        vent_count = 5;
        vent_spacing = width / (vent_count + 1);
        vent_height = height - wall_thickness * 4;
        
        // Add ventilation holes to back wall
        for (i = [1 : vent_count]) {
            translate([wall_thickness + i * vent_spacing, depth + 1, vent_height])
            rotate([90, 0, 0])
            linear_extrude(wall_thickness * 2) {
                circle(vent_size);
            }
        }
    }
}

module interior_texture() {
    if (add_interior_texture) {
        w = width - wall_thickness * 3;
        d = depth - wall_thickness * 3;
        texture_height = height / 2;
        ridge_height = 1;
        ridge_spacing = 15;
        
        // Create horizontal ridges on interior wall for climbing
        translate([wall_thickness * 2, wall_thickness * 2, wall_thickness])
        for (h = [ridge_spacing : ridge_spacing : texture_height]) {
            translate([0, 0, h])
            linear_extrude(height = ridge_height) {
                difference() {
                    offset(r = -wall_thickness)
                    hull(){
                        translate([corner_radius, corner_radius, 0]) 
                            circle(corner_radius);
                        translate([corner_radius, d - corner_radius, 0]) 
                            circle(corner_radius);
                        translate([w - corner_radius, corner_radius, 0]) 
                            circle(corner_radius);
                        translate([w - corner_radius, d - corner_radius, 0]) 
                            circle(corner_radius);
                    }
                    // Hollow out the center
                    offset(r = -wall_thickness * 2)
                    hull(){
                        translate([corner_radius, corner_radius, 0]) 
                            circle(corner_radius);
                        translate([corner_radius, d - corner_radius, 0]) 
                            circle(corner_radius);
                        translate([w - corner_radius, corner_radius, 0]) 
                            circle(corner_radius);
                        translate([w - corner_radius, d - corner_radius, 0]) 
                            circle(corner_radius);
                    }
                }
            }
        }
    }
}

module roof_line() {
    translate([0, -width/2, height]) 
    rotate([0, 90, 0])
    linear_extrude(width) {
        rotate(45)
        square((width/2) * sqrt(2));
        
        translate([0, width/2 * 2, 0])
        rotate(45)
        square((width/2) * sqrt(2));
    };
}

module door() {
    // Calculate door position (centered horizontally, positioned at door_height_factor of total height)
    translate([-2, depth/2, height * door_height_factor])
    rotate([0, 90, 0])
    cylinder(h = wall_thickness * 2, r = door_od / 2, $fn=60);
}

module mounting_hole() {
    // This is for a nail/screw to mount the birdhouse
    translate([depth-wall_thickness, width/2, height - 30])
    rotate([0, 90, 0])
    cylinder(h = wall_thickness * 2, r = 3, $fn=30);
    
    // Countersink
    translate([depth-wall_thickness, width/2, height - 27])
    rotate([0, 90, 0])
    cylinder(h = wall_thickness * 2, r = 5, $fn=30);
}

module base(){
    difference() {
        union() {
            translate([0, 0, 0])
            difference(){
                external_wall();
                internal_wall();
            }
            
            if (add_interior_texture) {
                interior_texture();
            }
        }
        
        roof_line();
        door();
        mounting_hole();
        drain();
        ventilation_holes();
    }
}

module rafter() {
    hull(){ 
        circle(roof_thickness);
        translate([0, (width / 2) * sqrt(2) + roof_thickness, 0])
            circle(roof_thickness);
    }
}

module ident() {
    hull(){ 
        circle(roof_thickness / 2);
        translate([0, width / 2, 0])
            circle(roof_thickness / 2);
    }
}

module idents() {
    // Add indents for roof placement
    translate([-roof_thickness, roof_thickness, wall_thickness + 1]) 
    union() { 
        linear_extrude(roof_thickness / 2){
            ident();
            rotate(90)
                ident();
        }
    }
    
    translate([-roof_thickness, roof_thickness, depth - wall_thickness - (roof_thickness / 2) - 1]) 
    union() { 
        linear_extrude(roof_thickness / 2){
            ident();
            rotate(90)
                ident();
        }
    }    
}

module roof() {
    translate([width, depth/2, height])
    rotate([0, -90, 0])
    rotate([0, 0, 45])
    union() { 
        linear_extrude(width + roof_thickness){
            rafter();
            rotate(90)
                rafter();
        }
        idents();
    }
}

// Render different bird house variants
module chickadee_house() {
    width = 100;
    depth = 100;
    height = 150;
    door_od = 32;
    
    color("white") base();
    color("darkgray") roof();
}

module bluebird_house() {
    width = 130;
    depth = 130;
    height = 170;
    door_od = 38;
    
    color("white") base();
    color("darkgray") roof();
}

module woodpecker_house() {
    width = 175;
    depth = 175;
    height = 300;
    door_od = 60;
    
    color("white") base();
    color("darkgray") roof();
}

// Default render
color("white") base();
color("darkgray") roof();

// Uncomment to preview different sizes:
// chickadee_house();
// bluebird_house();
// woodpecker_house();