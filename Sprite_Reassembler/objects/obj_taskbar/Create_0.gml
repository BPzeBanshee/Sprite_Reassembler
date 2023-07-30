parent = noone;
selection = 0;
selected = false;
mx = 0;
my = 0;

button_txt = [" START "," NEW FRAG "," DRAW GRID: N "," + "," - "];
draw_set_font(fnt_default);
for (var i=0;i<array_length(button_txt);i++) bw[i] = string_width(button_txt[i]);