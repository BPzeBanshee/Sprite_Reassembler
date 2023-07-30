draw_set_font(fnt_default);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var xx,yy,tx,ty;
// Main box window anchor
xx = x;
yy = y;

// Option start
tx = xx + 4;
ty = yy + 20;

// Window base
draw_set_color(c_dkgray);
draw_rectangle(xx,yy,xx+160,ty+160,false);

// [X] Close Button
draw_set_color(c_maroon);
if mouse_y > yy && mouse_y < yy+16 && mouse_x > xx+144 && mouse_x < xx+160
	{
	draw_set_color(c_red);
	if device_mouse_check_button(0,mb_left) then draw_set_color(c_fuchsia);
	} 
draw_rectangle(xx+144,yy,xx+160,yy+16,false);
draw_set_color(c_white);
draw_rectangle(xx+144,yy,xx+160,yy+16,true);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(xx+152,yy+8,"X");

if mouse_x > xx && mouse_x < xx+160
	{
	// Draggable window handle
	if mouse_y > yy && mouse_y < yy+16 && mouse_x < xx+142
		{
		if device_mouse_check_button(0,mb_left)
		then draw_set_color(c_ltgray)
		else draw_set_color(c_gray);
		draw_rectangle(xx,yy,xx+142,yy+16,false);
		draw_set_color(c_white);
		}
	
	// Option buttons
	if mouse_y > ty && mouse_y < ty+160
	    {
	    if device_mouse_check_button(0,mb_left)
	    then draw_set_color(c_lime)
	    else draw_set_color(c_green);
		
		for (var i=0;i<array_length(button_txt);i++)
			{
			if selection == i then draw_rectangle(xx,ty+(12*i),xx+160,ty+(12*(i+1)),false);
			}
	    if selection == 11 then draw_rectangle(xx,ty+140,xx+160,ty+160,false);
	    draw_set_color(c_white);
	    }
	}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(xx+4,yy,"obj_menu_splitter");
for (var i=0;i<array_length(button_txt);i++)
	{
	draw_text(tx,ty+(12*i),button_txt[i]+": ");
	}

draw_set_halign(fa_right);
tx = xx + 160 - 4;
ty = yy + 20;
draw_text(tx,ty,string(number_of_images)); ty += 12;
draw_text(tx,ty,string(images_per_row)); ty += 12;
draw_text(tx,ty,string(image_width)); ty += 12;
draw_text(tx,ty,string(image_height)); ty += 12;
draw_text(tx,ty,string(hori_cell_offset)); ty += 12;
draw_text(tx,ty,string(vert_cell_offset)); ty += 12;
draw_text(tx,ty,string(hori_pixel_offset)); ty += 12;
draw_text(tx,ty,string(vert_pixel_offset)); ty += 12;
draw_text(tx,ty,string(hori_sep)); ty += 12;
draw_text(tx,ty,string(vert_sep)); ty += 12;

//variable = <condition> ? <statement1 (if true)> : <statement2 (if false)>
var save_str = bool_savefrag ? "YES" : "NO";
draw_text(tx,ty,save_str); ty += 12;

draw_set_halign(fa_center);
tx = xx + 80;
ty = yy + 164;
draw_text(tx,ty,"CREATE FRAGMENT");

var n,sx,sy,bx,by,rx,ry;
sx = xx + 165;
sy = yy;
if sprite_exists(mygrid) then draw_sprite(mygrid,0,sx,sy);

draw_set_color(c_red);
n = 0;
for (by = vert_cell_offset; by < (number_of_images/images_per_row)+vert_cell_offset;by++)
    {
    for (bx = hori_cell_offset; bx < images_per_row+hori_cell_offset; bx++)
        {
        if n < number_of_images
            {
            rx = sx + hori_pixel_offset + (image_width * bx) + (hori_sep * bx);
            ry = sy + vert_pixel_offset + (image_height * by) + (vert_sep * by);
            draw_rectangle(rx,ry,rx+image_width-1,ry+image_height-1,true);
            n += 1;
            }
        }
    }
draw_set_alpha(1);