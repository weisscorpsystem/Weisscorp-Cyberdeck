/* * WEISSCORP SYSTEM - INDUSTRIAL EDITION v8.0 
 * OPEN DECK TERMINAL - SOURCE CODE
 * REVISION: R1.0 (PRODUCTION READY)
 */

/* [System Mode] */
mode = "assembly"; // [assembly, top, bottom, keys]
exploded_view = 30; // [0:5:50]

/* [Mechanical Parameters] */
$fn = 60;
eps = 0.05;
wall = 2.5;
top_w = 130.0;
top_h = 130.0;
pcb_depth = 10.0;
pcb_thick = 2.56;

/* [Interface Geometry] */
disp_w = 73.0;
disp_h = 54.0;
lcd_body_w = 76.5;
lcd_body_h = 63.5;
disp_glass_depth = 1.2;

kbd_w = 110.0;
kbd_y = 23.0;
cols = 10;
rows = 3;
btn_gap = 1.2;
btn_gap_y = 3.5;
btn_h = 8.0;
btn_depth = 4.5;
key_bevel = 0.8;
key_clearance = 0.45;
cut_clearance = 0.5;

/* [Fasteners] */
pb_hole_dist_x = 90.0;
pb_hole_dist_y = 100.0;
post_r = 4.0;
screw_r = 1.35;
thread_r = 1.15;
head_r = 2.5;
screw_head_depth = 8.0;

/* [Power Interface] */
rocker_cutout_w = 13.5;
rocker_cutout_h = 9.0;
pm_w = 20.0;
pm_h = 25.0;
pm_t = 1.6;

/* [Calculated Coordinates] */
d_min = 18.5;
d_max = 19.0;
wedge_z = 5.0;
top_bevel_height = 8.5;
tilt_ang = atan(wedge_z / top_h);
btn_w = (kbd_w - (btn_gap * (cols - 1))) / cols;

pcb_post_coords = [
    [-pb_hole_dist_x/2, -pb_hole_dist_y/2],
    [ pb_hole_dist_x/2, -pb_hole_dist_y/2],
    [-pb_hole_dist_x/2,  pb_hole_dist_y/2],
    [ pb_hole_dist_x/2,  pb_hole_dist_y/2]
];

function z_s(y) = y * (wedge_z / top_h);
seam_z = (z_s(top_h) + top_bevel_height + (-d_max)) / 2;
rocker_x = top_w/2 + pm_w/2 + 10.0;
rocker_z = ((-d_max + wall) + seam_z) / 2 - (rocker_cutout_h / 2);

pm_case_x = rocker_x;
pm_case_y = 116.0;
pm_case_z = -7.0;
disp_y = top_h - disp_h - 12.0;
start_x_kbd = (top_w - kbd_w) / 2;

module sharp_point(x, y, z) { translate([x, y, z]) cube([0.001, 0.001, 0.001]); }

module case_volume(off = 0) {
    tcb = 10.0;
    c_bl_x = (top_w - (top_w - 25.0)) / 2;
    c_bl_y = (top_h - 132.0) / 2 + 2.5;
    icb = tcb + off;
    p_off_val = 8.0 + off;
    p_tcb = tcb + p_off_val * 0.414;
    z_ext = top_bevel_height - off;
    union() {
        hull() {
            sharp_point(c_bl_x+off, c_bl_y+off, -d_min+off); sharp_point(top_w-c_bl_x-off, c_bl_y+off, -d_min+off);
            sharp_point(c_bl_x+off, top_h-c_bl_y-off, -d_max+off); sharp_point(top_w-c_bl_x-off, top_h-c_bl_y-off, -d_max+off);
            sharp_point(icb, off, z_s(off)); sharp_point(off, icb, z_s(icb));
            sharp_point(top_w-icb, off, z_s(off)); sharp_point(top_w-off, icb, z_s(icb));
            sharp_point(off, top_h-off, z_s(top_h-off)); sharp_point(top_w-off, top_h-off, z_s(top_h-off));
        }
        hull() {
            sharp_point(icb, off, z_s(off)); sharp_point(off, icb, z_s(icb));
            sharp_point(top_w-icb, off, z_s(off)); sharp_point(top_w-off, icb, z_s(icb));
            sharp_point(off, top_h-off, z_s(top_h-off)); sharp_point(top_w-off, top_h-off, z_s(top_h-off));
            sharp_point(p_tcb, p_off_val, z_s(p_off_val) + z_ext); sharp_point(p_off_val, p_tcb, z_s(p_tcb) + z_ext);
            sharp_point(top_w - p_tcb, p_off_val, z_s(p_off_val) + z_ext); sharp_point(top_w - p_off_val, p_tcb, z_s(p_tcb) + z_ext);
            sharp_point(p_off_val, top_h - p_off_val, z_s(top_h - p_off_val) + z_ext); sharp_point(top_w - p_off_val, top_h - p_off_val, z_s(top_h - p_off_val) + z_ext);
        }
    }
}

module perimeter_lip(is_cut = false) {
    c = is_cut ? 0.25 : 0; h = is_cut ? 2.5 : 2.0; z = is_cut ? seam_z - eps : seam_z;
    intersection() {
        translate([-50, -50, z]) cube([200, 200, h]);
        difference() { case_volume(wall/2 - c); case_volume(wall + c); }
    }
}

module logo_ventilation() {
    logo_scale = 1.0; slit_width = 1.1; slit_gap = 3.7; vent_slant = 26.56;
    translate([top_w/2, top_h/2 + 5.0, -d_max - 5.0]) intersection() {
        linear_extrude(height = 30) scale([logo_scale, logo_scale * 0.6]) offset(r=0.5) offset(delta=-0.5) 
            polygon(points=[[-27, 20], [-13, 20], [-9, 6], [-5, 20], [5, 20], [9, 6], [13, 20], [27, 20], [15, -20], [4, -20], [0, -6], [-4, -20], [-15, -20]]);
        rotate([0, 0, vent_slant]) for(x = [-80 : slit_width + slit_gap : 80]) translate([x, 0, 15.0]) cube([slit_width, 200.0, 40.0], center = true);
    }
}

module front_shell() {
    difference() {
        union() {
            difference() {
                intersection() { case_volume(0); translate([-50,-50,seam_z]) cube([200,200,100]); }
                case_volume(wall);
                perimeter_lip(true);
            }
            translate([top_w/2, top_h/2, top_bevel_height]) rotate([tilt_ang, 0, 0]) translate([0, 0, -pcb_depth]) 
                for(p = pcb_post_coords) translate([p[0], p[1], 0]) cylinder(h = pcb_depth, r = post_r);
        }
        translate([top_w/2, top_h/2, top_bevel_height]) rotate([tilt_ang, 0, 0]) {
            for(p = pcb_post_coords) {
                translate([p[0], p[1], -50]) cylinder(h = 100, r = screw_r);
                translate([p[0], p[1], 0.1 - screw_head_depth]) cylinder(h = 10, r = head_r);
            }
            translate([-disp_w/2, disp_y - top_h/2, -20]) cube([disp_w, disp_h, 50]);
            translate([-lcd_body_w/2, (disp_y - top_h/2) - (lcd_body_h - disp_h)/2, -20]) cube([lcd_body_w, lcd_body_h, 20 - disp_glass_depth]);
            for(r = [0:rows-1], c = [0:cols-1]) {
                curr_x = (start_x_kbd + c * (btn_w + btn_gap)) - top_w/2;
                curr_y = (kbd_y + r * (btn_h + btn_gap_y)) - top_h/2;
                if (!(r == 0 && c == 5)) {
                    w = (r == 0 && c == 4) ? (btn_w * 2) + btn_gap : btn_w;
                    translate([curr_x - cut_clearance/2, curr_y - cut_clearance/2, -20]) cube([w + cut_clearance, btn_h + cut_clearance, 50]);
                }
            }
        }
    }
}

module back_shell() {
    difference() {
        union() {
            difference() {
                union() { intersection() { case_volume(0); translate([-50,-50,seam_z-150]) cube([200,200,150]); } perimeter_lip(false); }
                case_volume(wall);
            }
            intersection() {
                case_volume(wall);
                translate([top_w/2, top_h/2, top_bevel_height]) rotate([tilt_ang, 0, 0]) translate([0, 0, -pcb_depth - pcb_thick]) 
                    for(p = pcb_post_coords) translate([p[0], p[1], -40]) {
                        cylinder(h = 40, r = post_r);
                        translate([0,0,40 - eps]) cylinder(h = pcb_thick - 0.2, r = thread_r);
                    }
            }
            // Rocker Switch Internal Support
            translate([rocker_x - 2.5, 2.5, rocker_z - 2.5]) 
                cube([rocker_cutout_w + 5, 8, rocker_cutout_h + 5]); 
        }
        translate([top_w/2, top_h/2, top_bevel_height]) rotate([tilt_ang, 0, 0]) translate([0, 0, -pcb_depth - pcb_thick]) 
            for(p = pcb_post_coords) translate([p[0], p[1], -10]) cylinder(h = 20, r = thread_r);
        
        // Rocker Switch Cutout
        translate([rocker_x, -1, rocker_z]) 
            cube([rocker_cutout_w, 15, rocker_cutout_h]);
        
        logo_ventilation();
    }
}

/* Rendering Logic */
if (mode == "assembly" || mode == "top")
    translate([0, 0, (mode == "assembly" ? 2.5 * exploded_view : 0)]) color("#363D43") front_shell();

if (mode == "assembly" || mode == "bottom")
    translate([0, 0, (mode == "assembly" ? -2.5 * exploded_view : 0)]) color("#4C565E") back_shell();
