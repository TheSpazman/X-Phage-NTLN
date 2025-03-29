
#region COLLISION WITH PLAYER-SHOT. (DESTROY BULLET AND DISPLAY DEBUG MSG)

if (place_meeting(x,y,obj_Shot1))
	{
		if (!instance_exists(obj_Shot1Impact))
			{
				
				var bullet_inst = instance_place(x,y,obj_Shot1);
				
				instance_create_depth(x,y,depth,obj_Shot1Impact);              
				image_speed = 2; 
				show_debug_message("I've Been Hit!");
				
				instance_destroy(bullet_inst);
				
				
			}
	}
	
#endregion
	
#region DESTROY OBJECT WHEN HIT-ANIMATION HAS PLAYED.

if (image_index > image_number -1)
	{
		instance_destroy();
	}
	
#endregion