draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_font(fnt_default);
draw_text(0,16,draw_txt);

if !saving
    {
	draw_text(mx,my,string(xx)+","+string(yy));
    if !selected then draw_text(mx,my+12,"IND: "+string(ind)+" ("+string(w)+","+string(h)+")")
    }
	
if array_length(sprite_indexes)>0
	{
	var spr = array_last(sprite_indexes);
	var sw = min(sprite_get_width(spr),64);
	var sh = min(sprite_get_height(spr),64);
	draw_sprite_stretched(array_last(sprite_indexes),ind,0,window_get_height()-sh,sw,sh);
	draw_text(0,window_get_height()-sh-16,"Current Sprite");
	}