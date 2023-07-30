// Configuration options
number_of_images = 32;
images_per_row = 8;
image_width = 16;
image_height = 16;
hori_cell_offset = 0;
vert_cell_offset = 0;
hori_pixel_offset = 1;
vert_pixel_offset = 1;
hori_sep = 1;
vert_sep = 1;
bool_savefrag = true;

button_txt = ["No. of images",
"Images per row",
"Image width",
"Image height",
"Hori. cell offset",
"Vert. cell offset",
"Hori. pixel offset",
"Vert. pixel offset",
"Hori. separation",
"Vert. separation",
"Save strip to file"];

// Mouse drag support
mheld = false;
mx = 0;
my = 0;
image_xscale = 144;
image_yscale = 16;
/*
Tried this, mostly works but GM is dodgy at quick horizontal drags whereas manual code works better

Create Event

drag_offsetX = 0;
drag_offsetY = 0;
Drag Start Event

drag_offsetX = x - event_data[?"posX"];
drag_offsetY = y - event_data[?"posY"];
Dragging Event

x = event_data[?"posX"] + drag_offsetX;
y = event_data[?"posY"] + drag_offsetY;
*/

// Open file
var f = get_open_filename_ext(".png","",environment_get_variable("USERPROFILE")+"\\Desktop","Select formatted grid image");
if f == ""
	{
	instance_destroy();
	exit;
	}
	
// index entry is passed to obj_ctrl_main which handles deletion
mygrid = sprite_add(f,0,0,0,0,0);
mymsg = -1;
parent = noone;