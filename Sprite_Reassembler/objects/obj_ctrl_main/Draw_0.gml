draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_font(fnt_default);
if !saving
    {
    if selected
        {
        if myfrag
        then draw_text(myfrag.x,myfrag.y+(myfrag.h*16),"F_IND: "+string(myfrag.start)+"\nF_R: "+string(myfrag.reverse));
        }
    }

draw_set_alpha(image_alpha);

// Mouse position
var ww = (w*inc_w) - 1;
var hh = (h*inc_h) - 1;
draw_set_color(c_blue);
draw_rectangle(xx-saving,yy-saving,xx+ww+saving,yy+hh+saving,saving);

if draw_grid
	{
	draw_set_alpha(1);
	draw_set_color(c_black);
	var wdw = window_get_width();
	var wdh = window_get_height();
	
	// draw horizontal
	for (var ly=0;ly<wdh;ly+=inc_h)
		{
		draw_line(0,ly,wdw,ly);
		}
		
	// draw vertical
	for (var lx=0;lx<wdw;lx+=inc_w)
		{
		draw_line(lx,0,lx,wdh);
		}
	}

/*if instance_exists(myfrag)
    {
    var x2,y2;
    x2 = myfrag.x;
    y2 = myfrag.y;
    ww = (myfrag.w*16) - 1;
    hh = (myfrag.h*16) - 1;
    draw_set_color(c_white);
    draw_rectangle(x2,y2,x2+ww,y2+hh,false);
    }*/
draw_set_alpha(1);