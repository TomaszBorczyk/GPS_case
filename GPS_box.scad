$fn=50;

difference(){
    minkowski(){
        cube([10, 20, 10], center=true);
        sphere(0.5);
    }

    translate([0, 0, 5]){
        cube([19, 29, 10], center=true);
    }

    minkowski(){
        cube([8, 18, 8], center=true);
        sphere(1);
    }
}

translate([0, 0, 10]){
    difference(){
        linear_extrude(5){
            minkowski() {
                circle(1);
                square([12, 22], center=true);
            }
        }

        linear_extrude(6){
            minkowski() {
                circle(1);
                square([9, 19], center=true);
            }
        }
    }
}
