/* [Bird House Dimensions] */
$fn=100;
// Width of the birdhouse (mm)
width = 100;
// Depth of the birdhouse (mm)
depth = 100;
// Height of the birdhouse (mm)
height = 150;
// Entrance hole diameter (mm)
door_od = 36;
// Drainage hole diameter (mm)
drain_od = 4;
// Wall thickness (mm)
wall_thickness = 3;
// Roof thickness as a fraction of width
roof_thickness_factor = 0.075;
// Calculate roof thickness
roof_thickness = width * roof_thickness_factor;
pool = true;


module external_wall(){
    hr = roof_thickness * 2;
    linear_extrude(height = height){
        hull(){
            translate([0,0,0]) {
                circle(roof_thickness);
            }
            translate([0,depth - hr,0]) {
                circle(roof_thickness);
            }translate([width - hr,0,0]) {
                circle(roof_thickness);
            }translate([width-hr,depth-hr,0]) {
                circle(roof_thickness);
            }
        }
    }
}

module internal_wall() {
    hr = roof_thickness * 2;
    w = width - wall_thickness * 2;
    d = depth - wall_thickness * 2;
    
    
    union(){
    translate([0,0,height / 3])
    hull() {
        translate([wall_thickness, wall_thickness,wall_thickness])
        linear_extrude(height = height){
            hull(){
                translate([0,0,0]) {
                    circle(roof_thickness);
                }
                translate([0,d - hr,0]) {
                    circle(roof_thickness);
                }translate([w - hr,0,0]) {
                    circle(roof_thickness);
                }translate([w-hr,d-hr,0]) {
                    circle(roof_thickness);
                }
            }
        }
        
        translate([(width/2) - (wall_thickness * 0) - roof_thickness, (width/2) - (wall_thickness * 0) - roof_thickness]) 
        sphere((width/ 2) - (wall_thickness) );
    }
    translate([-roof_thickness, -roof_thickness, -roof_thickness])
    drain();
    }
}

module drain() {
    offset = drain_od * 4;
    
    translate([width / 2, depth / 2, -2])
    linear_extrude(height) {
        circle(drain_od);
    }
    translate([width / 2, depth / 2 + offset, -2])
    linear_extrude(height) {
        circle(drain_od);
    }
    translate([width / 2, depth / 2 - offset, -2])
    linear_extrude(height) {
        circle(drain_od);
    }
    translate([width / 2 + offset, depth / 2, -2])
    linear_extrude(height) {
        circle(drain_od);
    }
    translate([width / 2 - offset, depth / 2, -2])
    linear_extrude(height) {
        circle(drain_od);
    }
}
module roof_line() {
    translate([0,-width/2,height]) 
    rotate([0,90,0])
    linear_extrude(depth) {
        rotate(45)
        square((width/2) * sqrt(2));
        
        translate([0,width/2 * 2,0])
        rotate(45)
        square((width/2) * sqrt(2));
    };
}

module door() {
    translate([-2, width /2, 3 * height / 5])
    rotate([0,90,0])
    cylinder(h = wall_thickness * 2, r = door_od / 2);
}

module key() {
    hull(){
    translate([depth-wall_thickness, width /2, height - 30 ])
    rotate([0,90,0])
    cylinder(h = wall_thickness * 2, r = 5);
    translate([depth-wall_thickness, width /2, height - 23 ])
    rotate([0,90,0])
    cylinder(h = wall_thickness * 2, r = 3);
    }
}

module base(){
    difference() {
        translate([roof_thickness, roof_thickness, 0])
            difference(){
                external_wall();
                internal_wall();
                
            }
        roof_line();
        door();
        key();
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
      translate([-roof_thickness, roof_thickness, wall_thickness + 0.5]) 
      union() { 
        linear_extrude(roof_thickness / 2){
            ident();
            rotate(90)
                ident();
        }
      }
      translate([-roof_thickness, roof_thickness, depth - wall_thickness - (roof_thickness / 2) - 0.5]) 
      union() { 
        linear_extrude(roof_thickness / 2){
            ident();
            rotate(90)
                ident();
        }
      }    
}
module roof() {
    translate([depth,width/2,height])
    rotate([0,-90,0])
    rotate([0,0,45])
        union() { 
            linear_extrude(depth + roof_thickness){
                rafter();
                rotate(90)
                    rafter();
            }
            idents();
        }
}


module predator_baffle() {
    length = roof_thickness*3;
    translate([-length + wall_thickness * 2, width /2, 3 * height / 5])
    rotate([0,90,0])
    difference(){
        union(){
            translate([0,0, length - wall_thickness])
            cylinder(h = wall_thickness, r = door_od / 1.5);
            cylinder(h = length, r = door_od / 2 - 0.5);
        }
        cylinder(h = length, r = (door_od / 2) - 0.5 - wall_thickness / 2);
        }
}

module pool_wall(){
    hr = roof_thickness * 2;
    linear_extrude(height = roof_thickness * 4){
        hull(){
            translate([0,0,0]) {
                circle(roof_thickness);
            }
            translate([0,depth - hr,0]) {
                circle(roof_thickness);
            }translate([width - hr,-roof_thickness,0]) {
                square(roof_thickness);
            }translate([width-hr,depth-hr,0]) {
                square(roof_thickness);
            }
        }
    }
}

module pool_innerwall() {
    hr = roof_thickness * 2;
    w = width - wall_thickness * 2;
    d = depth - wall_thickness * 2;
    
    
    union(){
    translate([0,0,0])
    hull() {
        translate([wall_thickness, wall_thickness,wall_thickness])
        linear_extrude(height = height){
            hull(){
                translate([0,0,0]) {
                    circle(roof_thickness);
                }
                translate([0,d - hr,0]) {
                    circle(roof_thickness);
                }translate([w - hr,-roof_thickness,0]) {
                    square(roof_thickness);
                }translate([w-hr,d-hr,0]) {
                    square(roof_thickness);
                }
            }
        }
    }
    }
}

module pool() {
translate([roof_thickness-depth+wall_thickness * 2, roof_thickness, 0])
    difference(){
        pool_wall();
        pool_innerwall();
        
    }
}


color("red") predator_baffle();
color("white") 
union() {
    base();
    if(pool) pool();
}

color("black") roof();

// Default render
//difference() {
//union() {
//color("white") base();
//color("darkred") roof();
//}
//
//translate([5, - height, -roof_thickness])
//cube(height *2);
//}