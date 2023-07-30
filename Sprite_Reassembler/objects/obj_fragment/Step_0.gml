/// @description  Button events
if selected
    {
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
    else
        {
        if keyboard_check_pressed(vk_left) then x -= round(inc_w/2);
        if keyboard_check_pressed(vk_right) then x += round(inc_w/2);
        if keyboard_check_pressed(vk_up) then y -= round(inc_h/2);
        if keyboard_check_pressed(vk_down) then y += round(inc_h/2);
        }
    if keyboard_check(ord("Z")) && alarm[1]==-1
        {
        if start > 0 then start -= 1;
        if start2 > 0 then start2 -= 1;
        alarm[1] = 5;
        }
    if keyboard_check(ord("X")) && alarm[1]==-1
        {
        if start < sprite_get_number(spr)-1 then start += 1;
        if start2 < sprite_get_number(spr)-1 then start2 += 1;
        alarm[1] = 5;
        }
    if keyboard_check_pressed(ord("C"))
        {
        reverse = !reverse;
        }
    if keyboard_check_pressed(vk_delete)
        {
        selected = false;
        with obj_ctrl_main
            {
            selected = false;
            myfrag = noone;
            }
        instance_destroy();
        }
    }
    
// For collision purposes
image_xscale = w;
image_yscale = h;

