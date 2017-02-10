// Simple OpenSCAD script to generate a case for the IR blaster.
// Created by Jay Boehm <jayrox@gmail.com> 2017

cube_half(size = [63, 43, 10], side = "top");

mirror([1,0,0]) 
    translate([10, 0, 0])
    cube_half(size = [63, 43, 10], side = "bottom");

module cube_half(size, side = "top") {
    w = size[0];
    d = size[1];
    h = (side == "top") ? size[2] : size[2] - 3;
    
    difference() {
        miniround([w, d, h], 2);
        // Hollow
        translate([1.5, 1.5, 2]) {
            miniround([w - 3, d - 3, h - 1], 1);    
        }

        // Outer Lip
        if (side == "top") {
            translate([0.20, 0.5, 8]) {
                miniround([w - 1.25, d - 1, 3], 1);    
            }
        }

        // LED ports
        rotate([90, 0, 0]) {
            translate([20, 10, -5]) 
                color("red")
                cylinder(h=10, r=4);
        }
        rotate([90, 0, 0]) {
            translate([15, 10, -5]) 
                color("red")
                cylinder(h=10, r=4);

        }
        // This squares off the edges around the LED ports
        rotate([90, 0, 0]) {
            translate([11, 10, -5])
                color("red")
                cube([13.25,5,10]);

        }

        if (side == "top") {
            // USB port
            translate([-5, 21, 3]) {
                color("red")
                cube([10, 8, h / 2 -1]);
            }
        }
    }
    // Outer Lip
    if (side == "bottom") {
        translate([0.5, 1, 0]) {
            difference() {
                miniround([w - 1, d - 2, h + 3], 1);    
                // Hollow
                translate([1, 1, 0]) {
                    miniround([w-3, d-4, h + 4], 1);    
                }
                // LED ports
                rotate([90, 0, 0]) {
                    translate([19.5, 10, -5]) 
                        color("red")
                        cylinder(h=10, r=4);
                }
                rotate([90, 0, 0]) {
                    translate([14.5, 10, -5]) 
                        color("red")
                        cylinder(h=10, r=4);

                }
                // This squares off the edges around the LED ports
                rotate([90, 0, 0]) {
                    translate([10.5, 10, -5])
                        color("red")
                        cube([13,5,10]);

                }
                // USB port
                translate([-5, 20, 7]) {
                    color("red")
                    cube([10, 8, h / 2 + 2]);
                }
            }
        }
    }
}

module miniround(size, radius) {
    $fn=50;
    x = size[0]-radius/2;
    y = size[1]-radius/2;

    minkowski()
    {
        cube(size=[x,y,size[2]]);
        cylinder(r=radius);
        // Using a sphere is possible, but will kill performance
        //sphere(r=radius);
    }
}
