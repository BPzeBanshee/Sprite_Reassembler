///@desc Methods

update_mouse_vars = function(){
mx = device_mouse_x_to_gui(0);
my = device_mouse_y_to_gui(0);
xx = mouse_x;
yy = mouse_y;
if frac(xx/inc_w) > 0 then while frac(xx/inc_w)>0 xx-=1;
if frac(yy/inc_h) > 0 then while frac(yy/inc_h)>0 yy-=1;
}

create_splitter = function(){
if !instance_exists(obj_menu_splitter)
	{
	var s = instance_create_depth(max(xx,16),max(yy,16),depth-1,obj_menu_splitter);
	s.parent = id;
	}
}

zoom_in = function(){
var cam = view_camera[view_current];
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);
var cx = camera_get_view_x(cam) + (cam_w/4);
var cy = camera_get_view_y(cam) + (cam_h/4);
camera_set_view_size(cam,cam_w/2,cam_h/2);
camera_set_view_pos(cam,cx,cy);
zoom += 1;
}
zoom_out = function(){
if zoom < 1 exit;
var cam = view_camera[view_current];
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);
var cx = camera_get_view_x(cam) - (cam_w/2);
var cy = camera_get_view_y(cam) - (cam_h/2);
camera_set_view_size(cam,cam_w*2,cam_h*2);
camera_set_view_pos(cam,cx,cy);
zoom -= 1;
}

strip_save = function(){
if saving
    {
	var g = draw_grid;
	if g then draw_grid = false;
	
    var z = zoom;
    while zoom > 1 zoom_out();
		
    var surf = surface_create(w*inc_w,h*inc_h);
    surface_copy_part(surf,0,0,application_surface,xx,yy,w*inc_w,h*inc_h);
    var s = sprite_create_from_surface(surf,0,0,w*inc_w,h*inc_h,0,0,0,0);
            
    var d = get_save_filename_ext("PNG file|*.png","strip.png",USER_DESKTOP,"Save generated strip to...");
    if d != "" then sprite_save_strip(s,d);
        
    while zoom < z zoom_in();
	if g then draw_grid = true;
	
    saving = false;
	draw_txt = main_txt;
    }
else
    {
    saving = true;
	draw_txt = saving_txt;
    }
}

load_project = function(){
var g = get_open_filename_ext("Project File|*.zip","Project.zip",USER_DESKTOP,"Load project placement file...");
if g != "" then scr_load_project(g);
}

save_project = function(){
var g = get_save_filename_ext("Project File|*.zip","Project.zip",USER_DESKTOP,"Save project placement file...");
if g != "" then scr_save_project(g);
}
