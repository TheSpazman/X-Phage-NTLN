// DEBUG THINGS // 



if keyboard_check_pressed(global.pause_key)
{
	switch (global.pause)
		{
			case false: instance_deactivate_all(true); global.pause = true; audio_play_sound(snd_accept,1,false); break;
			case true: 
				instance_activate_all(); 
				global.pause = false; 
				audio_play_sound(snd_back,1,false); 
				page = menu_page.main;
				break;
		}
}

if (!global.pause) exit;

menu_up = keyboard_check_pressed(global.up_key);
menu_down = keyboard_check_pressed(global.down_key); 
menu_accept = keyboard_check_pressed(global.confirm_key); 
menu_cancel = keyboard_check_pressed(global.cancel_key); 

var ds_grid = menu_pages[page];
var ds_height = ds_grid_height(ds_grid);

var pos = menu_down - menu_up;

if (inputting)
	{
		switch(ds_grid[# 1, menu_option[page]])
		{
		
			case menu_type.slider:
			
					switch(menu_option[page])
					{
						case 0: if(!audio_is_playing(msc_track01)) {audio_play_sound(msc_track01, 1, false);} break;
						case 1: if(!audio_is_playing(msc_track01)) {audio_play_sound(msc_track01, 1, false);} break;
						case 2: if(!audio_is_playing(snd_accept )) {audio_play_sound(snd_accept, 1, false); } break;
					}
			
				    var hinput = keyboard_check(global.right_key) - keyboard_check(global.left_key);
					if(hinput != 0)
						{
							ds_grid[# 3, menu_option[page]] += hinput*0.01; 
							ds_grid[# 3, menu_option[page]] = clamp(ds_grid[# 3, menu_option[page]], 0, 1);
							script_execute(ds_grid[# 2, menu_option[page]], ds_grid[# 3, menu_option[page]]);
						}
						
				
					break;
				
			case menu_type.shift:
					var hinput = keyboard_check_pressed(global.right_key) - keyboard_check_pressed(global.left_key);
					if(hinput != 0)
						{
							audio_play_sound(snd_accept,1,0);
							ds_grid[# 3, menu_option[page]] += hinput;
							ds_grid[# 3, menu_option[page]] = clamp(ds_grid[# 3, menu_option[page]], 0, array_length(ds_grid[# 4, menu_option[page]])-1);
						}
					break;
				
			case menu_type.toggle:
					var hinput = keyboard_check_pressed(global.right_key) - keyboard_check_pressed(global.left_key);
					if(hinput != 0)
						{
							audio_play_sound(snd_select,1,0);
							ds_grid[# 3, menu_option[page]] += hinput;
							ds_grid[# 3, menu_option[page]] = clamp(ds_grid[# 3, menu_option[page]], 0, 1);
						}
					break;
				
			case menu_type.input:
					var new_key = keyboard_lastkey;
					if (new_key != vk_enter and vk_escape)
						{
							if(new_key != ds_grid[# 3, menu_option[page]]) { audio_play_sound(snd_accept,1,0); }
							ds_grid[# 3, menu_option[page]] = new_key;
							variable_global_set(ds_grid[# 2, menu_option[page]], new_key);
						}
					 break;
				
			
		}
	}
else
	{
		audio_stop_sound(msc_track01);
		if(pos !=0)
		{
			menu_option[page] += pos;
			audio_play_sound(snd_select,1,0);
			if(menu_option[page] > ds_height-1)
				{
					menu_option[page] = 0;
				}
			
			if(menu_option[page] < 0) 
				{
					menu_option[page] = ds_height -1;
				}
			
		}
	}


	
if(menu_accept)
	{
		switch(ds_grid[# 1, menu_option[page]])
			{
				case menu_type.menu_transfer:
					{
						page = ds_grid[# 2, menu_option[page]]; 
						audio_play_sound(snd_accept,1,0);
						break;
					}
				case menu_type.script_trigger:
				
					script_execute(ds_grid[# 2, menu_option[page]]);
					break;
					
				case menu_type.slider:
					
				case menu_type.shift:
					
				case menu_type.toggle: 
				
					if(inputting){script_execute(ds_grid[# 2, menu_option[page]], ds_grid[# 3, menu_option[page]]);}
					
				case menu_type.input:
					{
						inputting = !inputting;
						 break;
					}
				
			}
	}

			
