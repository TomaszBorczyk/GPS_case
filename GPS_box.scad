$fn=50;
xxx = 0.01;

l_inner = 65;
w_inner = 33;
h_inner = 35;
t_wall = 1.5;
t_base = 1.5;

hole_corners_r = 2;
hole_corners_border_r = hole_corners_r + 0.5;
hole_corners_border_t = 0.2;

hole_corners_column_r = hole_corners_r + 0.5;

inner_curve = 1;
outer_curve = 1;

l_outer = l_inner + 2*t_wall;
w_outer = w_inner + 2*t_wall;
h_outer = h_inner + 2*t_base;

collision_margin = 0.5;

module children_mirror(axis=[1,0,0]){
    children();
    mirror(axis){
        children();
    }
}

module move_to_corners(translation=[l_inner/2 - hole_corners_r/2, w_inner/2 - hole_corners_r/2, -h_outer/2 - t_base/2]){
    translate(translation){
        children();
    }
}


difference(){
    minkowski(){
        cube([l_outer+2*t_wall+collision_margin, w_outer+2*t_wall+collision_margin, h_outer], center=true);
        // cube([l_outer+2*t_wall, w_outer+2*t_wall, h_outer], center=true);
        sphere(outer_curve);
    }

    translate([0, 0, h_outer/2]){
        cube([l_outer+10, w_outer+7, h_outer], center=true);
    }

    minkowski(){
        cube([l_outer+collision_margin, w_outer+collision_margin, h_inner], center=true);
        // cube([l_outer, w_outer, h_inner], center=true);
        sphere(inner_curve);
    }

    translate([8, 8, -25])
    cube([12, 5.5, 10]);

    translate([0, 0, -0.25-xxx])
    children_mirror([0, 1, 0]){
        children_mirror([1, 0, 0]){
            move_to_corners(){
                linear_extrude(10){
                    circle(hole_corners_r, center=true);
                }
                translate([0, 0, 0])
                linear_extrude(xxx+0.5){
                    circle(hole_corners_border_r, center=true);
                }
            }
        }
    }
}


translate([0, 50, 0]){
    
  
    
    difference(){
        minkowski(){
            cube([l_outer, w_outer, h_outer], center=true);
            sphere(outer_curve);
        }

        translate([0, 0, h_outer/2]){
            cube([l_outer+5, w_outer+5, h_outer], center=true);
        }

        difference(){
            minkowski(){
                cube([l_inner, w_inner, h_inner], center=true);
                sphere(inner_curve);
            }


            children_mirror([0, 1, 0]){
                children_mirror([1, 0, 0]){
                    translate([0, 0, t_base/2])
                    move_to_corners(){
                        difference(){
                            linear_extrude(h_inner/2+t_base - xxx){
                                circle(2*hole_corners_r, center=true);
                                
                            }
                            linear_extrude(h_inner/2+t_base + xxx){
                                circle(hole_corners_r, center=true);
                            }
                        }
                    }
                }
            }

        }
    }
}




*translate([0, 50, -17]){

    // adafruit
    translate([0, 0, 7])
    cube([51, 23, 8], center=true);

    // lipol
    translate([-7, 0, 0])
    cube([36, 31, 5], center=true);

    // gps
    translate([0, 0, 16.6])
    cube([33, 25, 10], center=true);

    // vibra
    translate([20, 0, 0])
    rotate([0, 0, 90])
    cube([23, 16, 1], center=true);

    translate([40, 0, 10])
    cube([23, 16, 27], center=true);
    
}


