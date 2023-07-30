///@func scr_load_project(dir)
///@param dir
function scr_load_project(dir){
	// error check
	if !file_exists(dir) then return -1;
	
	zip_unzip(dir,working_directory);
	
	
	// open as text file and read JSON array
	var f,s;
	f = file_text_open_read("project.json");
	s = file_text_read_string(f);
	file_text_close(f);
	var dsmap = json_decode(s);
	if ds_map_size(dsmap) < 1 then return -2;
	file_delete("project.json");
	
	// Wipe all existing fragments and sprites
	with obj_fragment instance_destroy();
	for (var i=0;i<array_length(sprite_indexes);i++)
		{
		if sprite_exists(sprite_indexes[i]) then sprite_delete(sprite_indexes[i]);
		}
	sprite_indexes = [];
	
	// Load sprites
	var imgmap = ds_map_find_value(dsmap,"sprite_map");
	for (var i=0;i<ds_map_size(imgmap);i++)
		{
		var img = ds_map_find_value(imgmap,string(i));
		if ds_map_size(img) < 1 then return -3;
		sprite_indexes[i] = sprite_add(string(i)+".png",img[?"subimages"],false,false,0,0);
		if sprite_exists(sprite_indexes[i]) then file_delete(string(i)+".png");
		}
	
	// Load fragments and assign sprites
	var fragmap = ds_map_find_value(dsmap,"fragment_map");
	for (var i=0;i<ds_map_size(fragmap);i++)
		{
		var nest,o;
		nest = ds_map_find_value(fragmap,string(i));
		if ds_map_size(nest) < 1 then return -4;
		o = instance_create_layer(x,y,layer,obj_fragment);
		o.x = nest[?"x"];
		o.y = nest[?"y"];
		o.start = nest[? "start"];
		o.start2 = o.start;
		o.w = nest[? "width"];
		o.h = nest[? "height"];
		o.reverse = nest[? "reverse"];
		o.sprnum = nest[? "sprite"]; // TODO: work out saving/loading of organised fragment strips first
		o.spr = sprite_indexes[o.sprnum];
		o.inc_w = sprite_get_width(o.spr);
		o.inc_h = sprite_get_height(o.spr);
		
		// set controller inc_w/h to last loaded
		inc_w = o.inc_w;
		inc_h = o.inc_h;
		}
	}

///@func scr_save_project(dir)
///@param dir
function scr_save_project(dir){
	// Error checking
	if instance_number(obj_fragment) == 0 then return -1;
	
	// prepare master ds_map
	var dsmap = ds_map_create();
	
	// Extract all sprites to a ZIP
	var myzip = zip_create();
	var arrlen = array_length(sprite_indexes);
	for (var i=0;i<arrlen;i++)
		{
		sprite_save_strip(sprite_indexes[i],string(i)+".png");
		zip_add_file(myzip,string(i)+".png",string(i)+".png");
		//file_delete(string(i)+".png");
		}
		
	// Put size metadata for images in a ds_map, add to master map
	var imglist = ds_map_create();
	for (var i=0;i<arrlen;i++)
		{
		var imgmap = ds_map_create();
		imgmap[? "subimages"] = sprite_get_number(sprite_indexes[i]);
		ds_map_add_map(imglist,string(i),imgmap);
		}
	ds_map_add_map(dsmap,"sprite_map",imglist);
	
	
	// Then, run through the object lists again and store variables
	var fraglist = ds_map_create();
	for (var i=0;i<instance_number(obj_fragment);i++)
		{
		var frag = ds_map_create();
		var o = instance_find(obj_fragment,i);
		frag[? "x"] = o.x;
		frag[? "y"] = o.y;
		frag[? "start"] = o.start;
		frag[? "width"] = o.w;
		frag[? "height"] = o.h;
		frag[? "reverse"] = o.reverse;
		frag[? "sprite"] = o.sprnum;
		ds_map_add_map(fraglist,string(i),frag);
		}
	ds_map_add_map(dsmap,"fragment_map",fraglist);
	
		
	// Finally, JSONify the map and save it
	var f,s;
	s = json_encode(dsmap);
	
	f = file_text_open_write("project.json");
	file_text_write_string(f,s);
	file_text_close(f);
	
	zip_add_file(myzip,"project.json","project.json");
	zip_save(myzip,dir);
	
	// Free the ds_maps
	ds_map_destroy(imglist);
	ds_map_destroy(fraglist);
	ds_map_destroy(dsmap);
	}