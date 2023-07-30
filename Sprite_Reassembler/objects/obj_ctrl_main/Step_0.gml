/// @description  BUTTON EVENTS

// MOUSE EVENTS
update_mouse_vars();

// VIEW CONTROL
var cam = view_camera[view_current];
var cx = camera_get_view_x(cam);
var cy = camera_get_view_y(cam);
var kx = 0;
var ky = 0;
if keyboard_check(ord("W")) then ky = -2;
if keyboard_check(ord("S")) then ky = 2;
if keyboard_check(ord("A")) then kx = -2;
if keyboard_check(ord("D")) then kx = 2;
camera_set_view_pos(cam,cx+kx,cy+ky);

// TODO: Copy zoom code from Offset Generator project
if keyboard_check_pressed(ord("9"))
    {
	zoom_in();
    }
if keyboard_check_pressed(ord("0")) && zoom > 1
    {
	zoom_out();
    }
    
// SYSTEM INPUTS
if keyboard_check_pressed(vk_escape)
    {
    game_end();
    }
if keyboard_check_pressed(vk_f1)
    {
    var txt = 
    @"ESC = Quit
    F1 = Show This Window
    F2 = Restart
    F4 = Fullscreen toggle
    F5 = Load Project File
    F6 = Save Project File
    CTRL + ARROWS = Set width/height for fragment creation/save area
    SPACE = Start Saving mode, set width/height then tap again to save to file
    WSAD = View Move
    1 = Open Sprite Splitter window
	8 = Toggle Grid with current sprite spacing
    9/0 = Zoom In/Out (WARNING: Zoom Out before using Save Mode for reliable results)
    
    Left Mouse (off fragment) = Create new fragment / De-select existing fragment
    Left Mouse (on fragment) = Select fragment
    Shift + Left Mouse = Select Multiple fragments
    
    While a fragment is selected:
    Z/X: Change starting subimage index
    C: Reverse index increment
    D: Set reverse index starting value (experimental)
    Right Mouse (anywhere) = De-Select All
    Right Mouse + Shift (on fragment) = Deselect fragment";
    show_message(txt);
    }
if keyboard_check_pressed(vk_f2)
    {
    game_restart();
    }
if keyboard_check_pressed(vk_f4)
    {
    window_set_fullscreen(!window_get_fullscreen());
    }
if keyboard_check_pressed(vk_f5)
    {
    load_project();
    }
if keyboard_check_pressed(vk_f6)
    {
    save_project();
    }
    
// MAIN UI FEATURES
if keyboard_check_pressed(ord("1"))
    {
    create_splitter();
    }
    
if instance_exists(obj_menu_splitter) then exit;
if array_length(sprite_indexes) == 0 then exit;
if draw_txt == init_txt then draw_txt = main_txt;

if keyboard_check_pressed(ord("8"))
	{
	draw_grid = !draw_grid;
	}

if !selected && keyboard_check_pressed(vk_space)
    {
	strip_save();
    }

if keyboard_check(ord("Z")) && alarm[1]==-1
    {
    if ind > 0 then ind -= 1;
    alarm[1] = 5;
    }
if keyboard_check(ord("X")) && alarm[1]==-1
    {
    if ind < sprite_get_number(array_last(sprite_indexes))-1 then ind += 1;
    alarm[1] = 5;
    }
if keyboard_check(vk_control)
    {
    if keyboard_check_pressed(vk_left)
        {
        if w > 1 then w -= 1;
        }
    if keyboard_check_pressed(vk_right)
        {
        w += 1;
        }
    if keyboard_check_pressed(vk_up)
        {
        if h > 1 then h -= 1;
        }
    if keyboard_check_pressed(vk_down)
        {
        h += 1;
        }
    }
    
if device_mouse_check_button_pressed(0,mb_left) && mouse_y > 16
    {
    var obj = instance_position(mx,my,obj_fragment);
    if obj != noone
        {
        // de-select existing object
        if !keyboard_check(vk_shift) then with myfrag selected = false;
        
        // select object if one is at given place
        selected = true;
        myfrag = obj;
        with myfrag selected = true;
        inc_w = myfrag.inc_w;
        inc_h = myfrag.inc_h;
        }
    else 
        {
        // reset selection first
        if !keyboard_check(vk_shift)
            {
            with myfrag selected = false;
            selected = false;
            myfrag = noone;
            }
			
		// Get sprite dimensions
		var newspr = array_last(sprite_indexes);
		inc_w = sprite_get_width(newspr);
		inc_h = sprite_get_height(newspr);
		update_mouse_vars();
            
        // finally create the new fragment and select it
        myfrag = instance_create_depth(xx,yy,depth+1,obj_fragment);
        myfrag.spr = array_last(sprite_indexes);
		myfrag.sprnum = array_length(sprite_indexes)-1;
        myfrag.inc_w = inc_w;
        myfrag.inc_h = inc_h;
        myfrag.start = ind;
        myfrag.w = w;
        myfrag.h = h;
        selected = true;
        with myfrag selected = true;
        }
	draw_txt = selected_txt;
    }
if device_mouse_check_button_pressed(0,mb_right)
    {
    // de-select object
    if keyboard_check(vk_shift)
        {
        var obj = instance_position(mx,my,obj_fragment);
        if obj != noone then with obj selected = false;
        }
    else
        {
        selected = false;
        with obj_fragment selected = false;
        myfrag = noone;
		draw_txt = main_txt;
		}
    }