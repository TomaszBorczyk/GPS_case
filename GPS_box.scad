$fn=50;
xxx = 0.01;

l_inner = 65;
w_inner = 32;
h_inner = 2*22;
t_wall = 1.5;
t_base = 1.5;

hole_corners_r = 1.9;
hole_corners_border_r = hole_corners_r + 0.5;
hole_corners_border_t = 0.2;


hole_corners_column_r = hole_corners_r + 1;

inner_curve = 1;
outer_curve = 1;

l_outer = l_inner + 2*t_wall;
w_outer = w_inner + 2*t_wall;
h_outer = h_inner + 2*t_base;

collision_margin = 1.2;

module children_mirror(axis=[1,0,0]){
    children();
    mirror(axis){
        children();
    }
}

module point_reflection(){
    children();
    mirror([1, 0, 0])
    mirror([0, 1, 0])
        children();
}

module children_rotate(angle=180){
    children()
    rotate(angle){
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
        cube([l_outer+2*t_wall+collision_margin, w_outer+2*t_wall+collision_margin, h_outer+collision_margin], center=true);
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


    //holes for case connection
    translate([0, 0, -0.25-xxx-collision_margin])
    mirror([0, 1, 0])
    point_reflection()
        move_to_corners(){
            linear_extrude(10){
                circle(hole_corners_r, center=true);
            }
            translate([0, 0, 0])
            linear_extrude(xxx+0.5){
                circle(hole_corners_border_r, center=true);
            }
        }
    
    //hole for USB
    translate([l_inner/2 + 3, 0, -3 + xxx])
    cube([5, 12, 9], center=true);
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

            //columns for case connection
            point_reflection()
            move_to_corners(){
                difference(){
                    linear_extrude(h_inner/2+t_base+collision_margin - xxx){
                        circle(hole_corners_column_r, center=true);
                    }
                    linear_extrude(h_inner/2+t_base+collision_margin + xxx){
                        circle(hole_corners_r, center=true);
                    }
                }
            }

        }

        //hole for button
        translate([20, 20, -h_inner/2 + t_base+3]){
        rotate([90, 0, 0])
            linear_extrude(5)
            circle(2, center=true);
        }

        //holes for Adafruit board mounting
        children_mirror([0, 1, 0])
        translate([l_inner/2 - 3, 9, -25]){
            linear_extrude(5)
            circle(1, center=true);
        }

        //hole in the wall for USB port
        translate([l_inner/2 + 1, 0, -h_inner/2 + 1.5])
        cube([5, 9, 5], center=true);
    }

      
}

