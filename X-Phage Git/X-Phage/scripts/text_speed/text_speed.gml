// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function text_speed(){
show_debug_message("Text Speed Changed to " + string(argument0));

	switch(argument0)
{
	case 0: global.tbox_text_speed = 0.5; break;
	case 1: global.tbox_text_speed = 1  ; break;
	case 2: global.tbox_text_speed = 2;   break;
	case 3: global.tbox_text_speed = 99;  break;
}
}