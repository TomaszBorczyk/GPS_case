$fn=50;
xxx = 0.01;

l_inner = 65;
w_inner = 33;
h_inner = 25;
t_wall = 0.5;
t_base = 2;

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
        cube([l_outer+t_wall+2*t_wall+collision_margin, w_outer+2*t_wall+collision_margin, h_outer], center=true);
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

    translate([0, 0, -xxx])
    children_mirror([0, 1, 0]){
        children_mirror([1, 0, 0]){
            move_to_corners(){
                linear_extrude(10){
                    circle(hole_corners_r, center=true);
                }
                linear_extrude(hole_corners_border_t){
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

        minkowski(){
            cube([l_inner, w_inner, h_inner], center=true);
            sphere(inner_curve);
        }

       
    }

    children_mirror([0, 1, 0]){
        children_mirror([1, 0, 0]){
            translate([0, 0, t_base/2])
            move_to_corners(){
                difference(){
                    linear_extrude(h_inner/2+t_base - xxx){
                        circle(hole_corners_column_r, center=true);
                    }
                    linear_extrude(h_inner/2+t_base + xxx){
                        circle(hole_corners_r, center=true);
                    }
                }
                
            }
        }
    }
}
