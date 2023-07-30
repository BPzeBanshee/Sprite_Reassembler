///@desc Alpha glow effect
if a == 0
    {
    image_alpha -= 0.025;
    if image_alpha < 0.025 then a = 1;
    }
else
    {
    image_alpha += 0.025;
    if image_alpha > 0.425 then a = 0;
    } 
alarm[0] = 1;