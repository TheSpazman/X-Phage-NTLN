// What to do if this hits a thing! 


	//WALL
	
	if (place_meeting(x,y,obj_wall))
		{
			
			if (!instance_exists(obj_Shot1Impact))
				{
					instance_create_depth(x,y,depth,obj_Shot1Impact);
							
				}			
			instance_destroy();
			
		}
		

				
			
			
		
		
	
