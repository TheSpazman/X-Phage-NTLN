// MENU CONTROLS // INPUT DETECTION 

up_key = keyboard_check_pressed(vk_up) 
		|| keyboard_check_pressed(ord("W"))
		|| gamepad_button_check_pressed(0,gp_padu)
		|| ((gamepad_axis_value(0,gp_axislv) < -0.5) && !alarm[0]);
		
down_key = keyboard_check_pressed(vk_down) 
		|| keyboard_check_pressed(ord("S")) 
		|| gamepad_button_check_pressed(0,gp_padd)
		|| ((gamepad_axis_value(0,gp_axislv) > 0.5) && !alarm[0]);
		
left_key = keyboard_check_pressed(vk_left) 
		|| keyboard_check_pressed(ord("A")) 
		|| gamepad_button_check_pressed(0,gp_padl)
		|| ((gamepad_axis_value(0,gp_axislh) > -0.5) && !alarm[0]);
		
right_key = keyboard_check_pressed(vk_right) 
		|| keyboard_check_pressed(ord("D")) 
		|| gamepad_button_check_pressed(0,gp_padr)
		|| ((gamepad_axis_value(0,gp_axislv) > 0.5) && !alarm[0]);
		
confirm_key = keyboard_check_pressed(vk_space) 
		|| keyboard_check_pressed(vk_enter)
		|| mouse_check_button_pressed(mb_left)
		|| gamepad_button_check_pressed(0, gp_face1)
		|| gamepad_button_check_pressed(0, gp_face3)
		|| gamepad_button_check_pressed(0, gp_start);
		
cancel_key = keyboard_check_pressed(vk_escape)
		|| keyboard_check_pressed(vk_backspace)
		|| gamepad_button_check_pressed(0, gp_face2);

// THUMBSTICK-PRESS LOCKOUT 

if ((gamepad_axis_value(0,gp_axislh) > 0.5)
	|| (gamepad_axis_value(0,gp_axislh) < -0.5)
	|| (gamepad_axis_value(0,gp_axislv) > 0.5)
	|| (gamepad_axis_value(0,gp_axislv) < -0.5))
{
	alarm[0] = 5;
}

// Is user using the mouse? 

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_x_to_gui(0);
if (_mx != lastmx || _my != lastmy) mouse_c = true;
lastmx = _mx;
lastmy = _my;

// If using the Keyboard, then Disable Mouse Controls.

if keyboard_check_pressed(vk_anykey) mouse_c = false;

// If using the Gamepad, then Disable Mouse Controls.

for (i=gp_face1; i<gp_axisrv; i++)
	{
		if gamepad_button_check(0,i)
			{
				mouse_c = false;
			}
	}

var anchorX = 280;					// Anchor point of Menu X
var anchorY = 225;					// Anchor point of Menu Y
var txt;							// Text String
var col;							// Color
var i;					            //
draw_set_font(global.font_main);	// Sets Main Game Font 
draw_set_valign(fa_top);			// Text Aligned w/ top
draw_set_halign(fa_left);			// Text Alighed w/ Left 
draw_set_alpha(1);					// Maxed Alpha Channel

var xx = anchorX;
var yy = anchorY; 

////////////////////////////////////////////////////////////////

//Setting new Menu Width

var _new_w = 0;

for (var i = 0; i < op_length; i++) 
	{
		var _op_w = string_width(option[menu_level,i]); 
		if _op_w > _new_w _new_w = _op_w;
	}
	
var ls = (xx - 30);
var rs = (xx + _new_w);

// Drawing the actual options in said menu! 

for (var i = 0; i < op_length; i++) 
	{
		if point_in_rectangle(_mx,_my,ls,yy-vS/3,rs,yy+vS/3) && mouse_c
			{
				if select != i audio_play_sound(snd_select,1,false);
				select = i; 
			}
			col = textColor1;
			txt = option[i];
			if select == i col = textColor2;
			draw_text_transformed_color(xx,yy,option[i],1,1,0,col,col,col,col,1);
			yy += vS; 
		
	}

// Move through menu -- Using the Keyboard!

if up_key
	{
		select -= 1; 
		if select < 0 select = op_length-1;
	}
	
if down_key
	{
		select += 1; 
		if select > op_length-1 select = 0;
	}
	
// Using the Options! 

if confirm_key 
{
	
	//show_message(select);
	var _sml = menu_level;
	
	switch(menu_level) 
		{
		
		// Main
		case 0: 
			switch(select)
				{
					// Start 
					case 0: 
		
						menu_level = 1; 
						break;
				
					// Settings
					case 1: 
						menu_level = 2; 
						break;
				
					// Information
					case 2: 
		
						break;
				
					// Quit
					case 3: 
						break;	
				}
				break; 
		
		// Start
		case 1:
			switch(select)
				{
					// Start a New Adventure 
					case 0:
						room_goto(rm_game);
						break;
						
					// Load a Saved Adventure 
					case 1:
						break;
						
					// Delete a Saved Adventure 
					case 2:
						break;
						
					// Return to Previous
					case 3:
						menu_level = 0;
						break;
				}
		
		
		// Settings 
		case 2:
			switch(select)
				{
					// Sound Volume 
					case 0:
						break;
						
					// Music Volume
					case 1:
						break;
						
					// Toggle Fullscreen
					case 2:
						if(window_get_fullscreen())
							{ 
								window_set_fullscreen(false);
							}
							else
							{
								window_set_fullscreen(true);
							}
						break;
						
					// Return to Previous
					case 3:
						menu_level = 0;
						break;
				}
		}
	
	//Set selection position back to top.
	if _sml != menu_level 
		{
			select = 0;	
		}
		
	//Run this code again to enforce correct options length 
	op_length = array_length(option[menu_level]); 
	
}