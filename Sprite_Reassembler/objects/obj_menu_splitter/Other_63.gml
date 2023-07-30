var i_d = ds_map_find_value(async_load, "id");
if i_d == mymsg
	{
	if ds_map_find_value(async_load, "status")
		{
	    var s = ds_map_find_value(async_load, "value");
		if s > -1 then switch selection
            {
            case 0: number_of_images = s; break;
            case 1: images_per_row = s; break;
            case 2: image_width = s; break;
            case 3: image_height = s; break;
            case 4: hori_cell_offset = s; break;
            case 5: vert_cell_offset = s; break;
            case 6: hori_pixel_offset = s; break;
            case 7: vert_pixel_offset = s; break;
            case 8: hori_sep = s; break;
            case 9: vert_sep = s; break;
            }
		}
	mymsg = -1;
	}