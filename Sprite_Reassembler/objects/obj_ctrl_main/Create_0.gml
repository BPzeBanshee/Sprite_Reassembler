USER_DESKTOP = environment_get_variable("USERPROFILE")+"\\Desktop";
init_txt = "";
main_txt = "Left Click: select/create fragment using existing sprite\nArrow keys: change size\nZ/X: change starting index";
saving_txt = "CTRL+Arrow keys: change zone size\nSPACE: save to file";
selected_txt = "Arrow Keys: move\nCTRL+Arrows: increase width/height\nDel: delete";
draw_txt = init_txt;

sprite_indexes = [];
ind = 0;
w = 1;
h = 1;
inc_w = 16;
inc_h = 16;
xx = 0;
yy = 0;
mx = 0;
my = 0;

myfrag = noone;
selected = false;
saving = false;

a = 0;
alarm[0] = 1;
zoom = 1;
draw_grid = false;

var bar = instance_create_depth(0,0,depth-1,obj_taskbar);
bar.parent = id;

// Declare methods
event_user(0);
