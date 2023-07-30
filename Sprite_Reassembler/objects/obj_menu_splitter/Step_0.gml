if mymsg != -1 then exit;

var tx,ty;
tx = x + 4;
ty = y + 20;

// [X] Button / enable mouse drag
if mouse_y > y && mouse_y < y+16
	{
	if mouse_x > x+144 && mouse_x < x+160
		{
		if device_mouse_check_button_released(0,mb_left) then instance_destroy();
		}
	}

// Main Options
if mouse_x > x && mouse_x < x+160
&& mouse_y > ty && mouse_y < ty+160
    {
	selection = -1;
	
	// Buttons
	for (var i=0;i<array_length(button_txt);i++)
		{
		if mouse_y > ty+(12*i) && mouse_y < ty+(12*(i+1)) then selection = i;
		}
		
	// Big button
	if mouse_y > ty+140 && mouse_y < ty+160 then selection = 11;
    if keyboard_check_pressed(vk_delete) then instance_destroy();

    if device_mouse_check_button_released(0,mb_left)
		{
		var v = -1;
        switch selection
            {
            case 0: v = number_of_images; break;
            case 1: v = images_per_row; break;
            case 2: v = image_width; break;
            case 3: v = image_height; break;
            case 4: v = hori_cell_offset; break;
            case 5: v = vert_cell_offset; break;
            case 6: v = hori_pixel_offset; break;
            case 7: v = vert_pixel_offset; break;
            case 8: v = hori_sep; break;
            case 9: v = vert_sep; break;
			case 10: bool_savefrag = !bool_savefrag; break;
			case 11: alarm[1] = 1; break;
			default: break;
            }
			
		if v == -1 then exit;
		mymsg = get_integer_async(button_txt[selection],v);
		/*var s = get_integer("Change value",v);
		if s > -1 then switch selection
            {
            case 1: number_of_images = s; break;
            case 2: images_per_row = s; break;
            case 3: image_width = s; break;
            case 4: image_height = s; break;
            case 5: hori_cell_offset = s; break;
            case 6: vert_cell_offset = s; break;
            case 7: hori_pixel_offset = s; break;
            case 8: vert_pixel_offset = s; break;
            case 9: hori_sep = s; break;
            case 10: vert_sep = s; break;
            }*/
        }
    }
    
// Mouse drag
/*if mheld
	{
	if device_mouse_check_button(0,mb_left)
		{
		if mx == 0 && my == 0
			{
			mx = mouse_x - x;
			my = mouse_y - y;
			}
		x = mouse_x - mx;
		y = mouse_y - my;
		}
	else
		{
		mx = 0;
		my = 0;
		mheld = false;
		}
	}
*/