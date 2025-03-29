// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function change_volume(){
show_debug_message("Changing Volume to " +string(argument0));

var type = menu_option[page];

switch(type)
{
	case 0: audio_master_gain(argument0); break; //if(audio_is_playing(msc_track01)) {audio_stop_sound(msc_track01);}	break;
	case 1: audio_group_set_gain(xp_music, argument0, 0) break; //if(audio_is_playing(msc_track01)) {audio_stop_sound(msc_track01);}	break;
	case 2: audio_group_set_gain(xp_sfx, argument0, 0) break; if(audio_is_playing(snd_accept)) {audio_stop_sound(snd_accept);} break;
}
}

						
						 
						 	
					