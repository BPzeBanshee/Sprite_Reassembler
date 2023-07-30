draw_set_alpha(1);
var i,xx,yy;
if reverse
    {
    i = start2;
    // TODO: Find a way to calculate the amount of spacing as if looped forward
    // then draw reverse to get the images the right way around if they were
    // reversed before. Example: engines
    for (yy=0;yy<(inc_h*h);yy+=inc_h)
        {
        for (xx=0;xx<(inc_w*w);xx+=inc_w)
            {
            draw_sprite(spr,i,x+xx,y+yy);
            if i > 0 then i -= 1;
            }
        }
    }
else
    {
    i = start;
    for (yy=0;yy<(inc_h*h);yy+=inc_h)
        {
        for (xx=0;xx<(inc_w*w);xx+=inc_w)
            {
            draw_sprite(spr,i,x+xx,y+yy);
            if i < sprite_get_number(spr)-1 then i += 1;
            }
        }
    if keyboard_check_pressed(ord("V")) then start2 = i;
    }
    
if selected
    {
    if instance_exists(obj_ctrl_main)
    then draw_set_alpha(obj_ctrl_main.image_alpha)
    else draw_set_alpha(0.33);
    var ww,hh;
    ww = (w*inc_w) - 1;
    hh = (h*inc_h) - 1;
    draw_set_color(c_white);
    draw_rectangle(x,y,x+ww,y+hh,false);
    draw_set_alpha(1);
    }

