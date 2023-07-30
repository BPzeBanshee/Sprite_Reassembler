if parent == noone exit;

mx = device_mouse_x_to_gui(0);
my = device_mouse_y_to_gui(0);

selection = -1;
if my < 16
	{
	var w = 0;
	for (var i=0;i<array_length(button_txt);i++)
		{
		if mx > w && mx < w+bw[i] then selection = i;
		w += bw[i];
		}
		
	if mx > room_width-16 && mx < room_width then selection = 666;
		
	if device_mouse_check_button_released(0,mb_left) then selected = true;
	}
	
if selected
	{
	switch selection
		{
		default: break;
		case 1: parent.create_splitter(); break;
		case 2:
			{
			parent.draw_grid = !parent.draw_grid;
			
			if parent.draw_grid
			then button_txt[2] = string_replace(button_txt[2],"N ","Y ")
			else button_txt[2] = string_replace(button_txt[2],"Y ","N ");
			break;
			}
		case 3: parent.zoom_in(); break;
		case 4: parent.zoom_out(); break;
		case 666: game_end(); break;
		}
	
	selected = false;
	}