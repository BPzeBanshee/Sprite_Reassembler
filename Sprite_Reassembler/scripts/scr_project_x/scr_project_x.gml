///@func scr_load_project(dir)
///@param dir
function scr_load_project(dir){
	// error check
	if !file_exists(dir) then return -1;
	
	// unzip to localappdata\sprite_reassembler to work with archive
	zip_unzip(dir,working_directory);
	
	// open as text file and read JSON array
	var s = "";
	var f = file_text_open_read("project.json");
	while !file_text_eof(f) s += file_text_readln(f);
	file_text_close(f);
	file_delete("project.json");
	
	// Convert read string to JSON struct
	var myjson = json_parse(s);
	if !is_struct(myjson) then return -2;
	
	// Wipe all existing fragments and sprites
	with obj_fragment instance_destroy();
	for (var i=0;i<array_length(sprite_indexes);i++)
		{
		if sprite_exists(sprite_indexes[i]) then sprite_delete(sprite_indexes[i]);
		}
	sprite_indexes = [];
	
	// Load sprites
	if !variable_struct_exists(myjson,"sprite_map") then return -3;
	
	var imgmap = variable_struct_get(myjson,"sprite_map");
	for (var i=0; i<variable_struct_names_count(imgmap); i++)
		{
		var img = variable_struct_get(imgmap,string(i));
		sprite_indexes[i] = sprite_add(string(i)+".png",img[$ "subimages"],false,false,0,0);
		if sprite_exists(sprite_indexes[i]) then file_delete(string(i)+".png");
		delete img;
		}
	
	// Load fragments and assign sprites
	if !variable_struct_exists(myjson,"fragment_map") then return -4;
	var fragmap = variable_struct_get(myjson,"fragment_map");
	
	var nest,o;
	for (var i=0;i<variable_struct_names_count(fragmap);i++)
		{
		nest = variable_struct_get(fragmap,string(i));
		o = instance_create_layer(x,y,layer,obj_fragment);
		o.x = nest[$ "x"];
		o.y = nest[$ "y"];
		o.start = nest[$ "start"];
		o.start2 = o.start;
		o.w = nest[$ "width"];
		o.h = nest[$ "height"];
		o.reverse = nest[$ "reverse"];
		o.sprnum = nest[$ "sprite"];
		o.spr = sprite_indexes[o.sprnum];
		o.inc_w = sprite_get_width(o.spr);
		o.inc_h = sprite_get_height(o.spr);
		
		// set controller inc_w/h to last loaded
		inc_w = o.inc_w;
		inc_h = o.inc_h;
		
		delete nest;
		}
		
	delete imgmap;
	delete fragmap;
	delete myjson;
	}

///@func scr_save_project(dir)
///@param dir
function scr_save_project(dir){
	// Error checking
	if instance_number(obj_fragment) == 0 then return -1;
	
	// prepare master ds_map
	var myjson = {
	fragment_map: {},
	sprite_map: {}
	};
	
	// Extract all sprites to a ZIP
	var myzip = zip_create();
	var arrlen = array_length(sprite_indexes);
	for (var i=0;i<arrlen;i++)
		{
		sprite_save_strip(sprite_indexes[i],string(i)+".png");
		zip_add_file(myzip,string(i)+".png",string(i)+".png");
		}
		
	// Put size metadata for images in a ds_map, add to master map
	for (var i=0;i<arrlen;i++)
		{
		var imgmap = {};
		imgmap[$ "subimages"] = sprite_get_number(sprite_indexes[i]);
		variable_struct_set(myjson.sprite_map,string(i),imgmap);
		}
	show_message(myjson.sprite_map);
	
	// Then, run through the object lists again and store variables
	for (var i=0;i<instance_number(obj_fragment);i++)
		{
		var o = instance_find(obj_fragment,i);
		var frag = {};
		frag[$ "x"] = o.x;
		frag[$ "y"] = o.y;
		frag[$ "start"] = o.start;
		frag[$ "width"] = o.w;
		frag[$ "height"] = o.h;
		frag[$ "reverse"] = o.reverse;
		frag[$ "sprite"] = o.sprnum;
		variable_struct_set(myjson.fragment_map,string(i),frag);
		}
		
	// Finally, JSONify the map and save it
	var s = json_stringify(myjson,true);
	
	var f = file_text_open_write("project.json");
	file_text_write_string(f,s);
	file_text_close(f);
	
	zip_add_file(myzip,"project.json","project.json");
	zip_save(myzip,dir);
	
	// Free the structs
	delete myjson;
	}