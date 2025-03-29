


if position_meeting(mouse_x, mouse_y, id) && mouse_check_button_pressed(mb_left) && !instance_exists(obj_textbox)
	{
		
		create_textbox(text_id);
		show_debug_message("This should be working if you pressed the Action button!")
		
	}
	
if instance_place(x,y, obj_player) && keyboard_check_pressed(global.secondary_fire_key) && !instance_exists(obj_textbox)
	{
		
		create_textbox(text_id);
		show_debug_message("This should be working if you pressed the Action button!")
		
	}
	









