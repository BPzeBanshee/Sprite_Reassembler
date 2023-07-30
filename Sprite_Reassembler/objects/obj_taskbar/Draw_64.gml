draw_set_font(fnt_default);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Main box window anchor
var left,right,top,bottom;
left = 0; right = room_width;
top = 0; bottom = room_height;

var height = top+16;
var mb = device_mouse_check_button(0,mb_left);

// Window base
draw_set_color(c_dkgray);
draw_rectangle(left,top,right,height,false);

// [X] Close Button
draw_set_color(c_maroon);
if selection == 666
	{
	draw_set_color(c_red);
	if mb then draw_set_color(c_fuchsia);
	} 
draw_rectangle(right-14,top+1,right-2,height,false);
draw_set_color(c_white);
draw_rectangle(right-14,top+1,right-2,height,true);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(right-8,height/2,"X");

if my < top+16
	{
	if mb then draw_set_color(c_lime) else draw_set_color(c_green);
	
	var w = 0;
	for (var i=0;i<array_length(button_txt);i++)
		{
		if selection == i then draw_rectangle(left+w,0,left+w+bw[i],height,false);
		w += bw[i];
		}
	
	draw_set_color(c_white);
	}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
var tx = 0;
var ty = 0;
w = 0;
for (var i=0;i<array_length(button_txt);i++)
	{
	draw_text(tx+w,ty,button_txt[i]);
	w += bw[i];
	}