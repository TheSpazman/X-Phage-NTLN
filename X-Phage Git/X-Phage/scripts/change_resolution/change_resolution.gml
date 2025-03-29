// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function change_resolution(){
show_debug_message("Resolution Changed");

switch(argument0)
{
	case 0: window_set_size(640,400); break;
	case 1: window_set_size(1280,800); break;
	case 2: window_set_size(1920,1200); break;
	case 4: break;
}
}