
if place_meeting(x, y, obj_player) && !instance_exists(obj_warp)
	{
	var inst = instance_create_depth(0,0,99,obj_warp);
	inst.target_x		= target_x;
	inst.target_y		= target_y;
	inst.target_room	= target_room;
	}









