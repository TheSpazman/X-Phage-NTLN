// Main 'do stuff' code for the game's main gun. 

x = obj_player.x;									//Gun X-Position
y = obj_player.y-28;								//Gun Y-Position
firingdelay = firingdelay - 1;                      //Reduce Fire-Delay by 1

// PRODUCE A SHOT WHEN FIRED

	if (keyboard_check_pressed(fireKey)) && (firingdelay < 0) && (obj_player.playerCanShoot)// IF EITHER FIRE-KEY IS HELD AND DELAY IS 0'D,
		
		{
			firingdelay = 15;																										//SET DELAY TO 15 TICKS
			show_debug_message("SHOT FIRED!");
			audio_play_sound(firesound, 1, false,0.5);																			//WEAPONS-FIRE SOUND
			with (instance_create_layer(x,y,"Instances",obj_Shot1))																//AND DO THIS WHILE LOADING THIS OBJECT...
			
				{
					hspeed = hsp * dir
				}
		}
		else if (!obj_player.playerCanShoot)
		{
			show_debug_message("CANNOT SHOOT NOW!");
		}
	