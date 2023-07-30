/// @description  Generate the fragment
if !sprite_exists(mygrid) then exit;

var spr,surf;
spr = noone;
surf = surface_create(image_width,image_height);
surface_set_target(surf);
draw_clear_alpha(c_black,0);
surface_reset_target();

var n,bx,by,rx,ry;
n = 0;
for (by = vert_cell_offset; by < (number_of_images/images_per_row)+vert_cell_offset; by++)
    {
    for (bx = hori_cell_offset; bx < images_per_row+hori_cell_offset; bx++)
        {
        if n < number_of_images
            {
            rx = hori_pixel_offset + (image_width * bx) + (hori_sep * bx);
            ry = vert_pixel_offset + (image_height * by) + (vert_sep * by);
            surface_set_target(surf);
            draw_clear_alpha(c_black,0);
            draw_sprite_part(mygrid,0,rx,ry,image_width,image_height,0,0);
            surface_reset_target();
            if !sprite_exists(spr)
            then spr = sprite_create_from_surface(surf,0,0,image_width,image_height,false,false,0,0)
            else sprite_add_from_surface(spr,surf,0,0,image_width,image_height,false,false);
            n += 1;
            } 
        }       
    }
if bool_savefrag
	{
	var s;
	s = get_save_filename_ext("PNG File|*.png","fragment_strip.png",working_directory,"Save fragment strip...");
	if s != ""
	    {
		// YoYo blocks saving to app directory which is shit
		if filename_path(s) == program_directory
			{
			s = environment_get_variable("USERPROFILE")+"\\Desktop\\"+filename_name(s);
			show_message("Program directory is blocked by YoYo: saving as "+string(s)+" instead");
			}
	    sprite_save_strip(spr,s);
	    if file_exists(s) then show_message("Strip successfully saved to "+s);
	    }
	}

array_push(parent.sprite_indexes,spr);
instance_destroy();