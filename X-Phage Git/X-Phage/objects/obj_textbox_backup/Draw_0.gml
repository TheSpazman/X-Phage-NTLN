/// @description Insert description here
// You can write your code in this editor

accept_key = keyboard_check_pressed(global.confirm_key);	
tbox_x = camera_get_view_x( view_camera[0] ) +26;
tbox_y = camera_get_view_y( view_camera[0] ) +342;

//-----Setup 

if tbox_setup == false 
	{
		
		tbox_setup = true; 
		obj_player.playerCanMove = 0;
		draw_set_font(global.font_main);
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		
		// Loop through pages 
		
		for (var p = 0; p < tbox_page_number; p++)
			{
				
				//Find how many characters are on each page, then store number in the 'tbox_text_length' array.
				tbox_text_length[p] = string_length(tbox_text[p]);
				
				
				//Get X-Position of Textbox
					// Character on Left / Right / Center (Simplified from tutorial, since the portraits would always be visible / present, no offsetting. 
						tbox_text_x_offset[p] = 65; 
						left_vdu_x_offset[p] = -26; 
						left_vdu_y_offset[p] = -24;
						right_vdu_x_offset[p] = 552;
						right_vdu_y_offset[p] = -24;
						
				
					
				//Setting individual characters, establish linebreaks. 
					for (var c = 0; c < tbox_text_length[p]; c++)
						{
							var _char_pos = c+1;
							
							//Storing individual characters in the 'char' / character array 
							char[c, p] = string_char_at(tbox_text[p], _char_pos);
							
							//Get current width of line. 
							var _txt_up_to_char = string_copy( tbox_text[p], 1, _char_pos);
							var _current_text_w = string_width( _txt_up_to_char) - string_width(char[c, p]);
							
							//Get the last free space. 
							if char[c, p] == " " { last_free_space = _char_pos+1 }; 
							
							//Get line breaks
							if _current_text_w - line_break_offset[p] > tbox_line_width
								{
									line_break_pos[ line_break_num[p], p] = last_free_space;
									line_break_num[p]++; 
									var _txt_up_to_last_space = string_copy( tbox_text[p], 1, last_free_space);
									var _last_free_space_string = string_char_at(tbox_text[p], last_free_space);
									line_break_offset[p] = string_width(_txt_up_to_last_space) - string_width(_last_free_space_string); 
								}
						}
					
					//Getting Each Character's Coordinates -- 
					for (var c = 0; c < tbox_text_length[p]; c++) 
						{
							var _char_pos = c+1; 
							var _txt_x = tbox_x + tbox_text_x_offset[p] + tbox_border; 
							var _txt_y = tbox_y + tbox_border; 
							
							//get current width of line
							var _txt_up_to_char = string_copy( tbox_text[p], 1, _char_pos);
							var _current_text_w = string_width( _txt_up_to_char ) - string_width( char[c, p] );
							var _txt_line = 0; 
							
							//Compensate for string-breaks 
								for (var lb = 0; lb < line_break_num[p]; lb++)
									{
										
										//If current looped character is after line-break; 
										if _char_pos >= line_break_pos[lb, p]
											{
												var _str_copy = string_copy(tbox_text[p], line_break_pos[lb, p], _char_pos-line_break_pos[lb, p]);
												_current_text_w = string_width(_str_copy);
												
												//Record the actual line this character should appear on 
												_txt_line = lb+1; // +1 since lb starts at 0. 
											}
										
									}
							
							//Add to X + Y Coordinates baed on new info.
							char_x[c, p] = _txt_x + _current_text_w;
							char_y[c, p] = _txt_y + _txt_line*tbox_line_spacing;
							
						}
				
			}
		
	}
	

//-----Typing the text onto the screen. 
if text_pause_timer <= 0
	{
		if tbox_draw_char < tbox_text_length[tbox_page]                                 // If the text has not finished typing, then
			{
				tbox_draw_char += global.tbox_text_speed;                               // Draw each character at the specified global text-speed.
				tbox_draw_char = clamp(tbox_draw_char, 0, tbox_text_length[tbox_page]); // and ensure no characters outside of the string specified are drawn. 
				var _check_char = string_char_at(tbox_text[tbox_page], tbox_draw_char); // Check each character as it is passed-through
				
				if _check_char == "." || _check_char == "!" || _check_char == "?"		// If the character happens to be a form of punctuation... 
					{
						text_pause_timer = text_pause_time;								// Set the pause timer and start it. Count down from alloted time.
						if !audio_is_playing(snd[tbox_page]){							// If the textbox sound for this particular box is not playing, then..
							audio_play_sound(snd[tbox_page], 1, false);					// play the textbox sound for this particular box, 
							audio_sound_pitch(snd[tbox_page], random_range(0.9,1.0));	// ..and randomize the pitch of the audio slightly. 
						}
							
					}
					else																	// Otherwise.. 
					{
						//Typing sound 
						
						if snd_count < snd_delay											// If the current sound-count is lower than the delay-timer, then
							{
								snd_count++;												// Increment the sound-count by 1. 
							}else{															// otherwise..
								snd_count = 0;												// zero-out the sound-count timer
								audio_play_sound(snd[tbox_page], 1, false);                 // and play the textbox sound for this particular box, 
								audio_sound_pitch(snd[tbox_page], random_range(0.9,1.0));   // and randomize the pitch of the audio slightly.
							}
					}
				
				
			}
	} else {
		
	text_pause_timer--;																		//	Decrement the text-pause-timer by 1.
	
	}

//----- Flip through pages of stored text. 
if accept_key
	{
		
		//If the typing completes, go to next page. 
		
	if tbox_draw_char == tbox_text_length[tbox_page]
		{
			//Next Page. 
			if tbox_page < tbox_page_number-1
				{
					tbox_page++;
					tbox_draw_char = 0; 
				}
				//Destroy the textbox. 
			else 
				{
					//link text for options
					if option_number > 0 
						{
							create_textbox(option_link_id[option_pos]);
						}
					instance_destroy();
					
				}
		}
	//If not done typing... 
	else 
		{
			tbox_draw_char = tbox_text_length[tbox_page];
		}
	
		obj_player.playerCanMove = 1;
		
	}


//----- Draw the textbox. 
var _tbox_x = tbox_x + tbox_text_x_offset[tbox_page];						// Textbox X-Position
var _tbox_y = tbox_y;														// Textbox Y-Position
//tbox_image += tbox_image_speed;												// This is not used.
tbox_sprite_w = sprite_get_width(tbox_sprite[tbox_page]);
tbox_sprite_h = sprite_get_height(tbox_sprite[tbox_page]);

//---- Draw the speaking character and boxes -- Left and Right VDUs

if left_vdu_sprite[tbox_page] != noone 
	{
		
		sprite_index = left_vdu_sprite[tbox_page];																				// Left VDU Sprite
		var _leftvdu_x = tbox_x + left_vdu_x_offset[tbox_page];																	// Left VDU X-Pos
		var _leftvdu_y = tbox_y + left_vdu_y_offset[tbox_page];																	// Left VDU Y-Pos
		if tbox_draw_char == tbox_text_length[tbox_page] { image_index = 0 };													// Stop animating when text finishes. 
		
		//----- Drawing the Left VDU 
		
		draw_sprite_ext(sprite_index, image_index,_leftvdu_x, _leftvdu_y,1,1,0,c_white,1);										// Drawing Left VDU Contents
		
		draw_sprite_ext(tbox_lvdu_border_flicker[0], tbox_lvdu_border_flicker_speed,_leftvdu_x, _leftvdu_y,1,1,0,c_white,0.2);	// Drawing Left VDU Flicker
		draw_sprite_ext(tbox_lvdu_border, tbox_lvdu_border_image,_leftvdu_x, _leftvdu_y,1,1,0,c_white,1);						// Drawing the Border
		
			
		
	}
	
	
if  right_vdu_sprite[tbox_page] != noone 
	{
		
		sprite_index = right_vdu_sprite[tbox_page];
		if tbox_draw_char == tbox_text_length[tbox_page] { image_index = 0 };
		var _rightvdu_x = tbox_x + right_vdu_x_offset[tbox_page];
		var _rightvdu_y = tbox_y + right_vdu_y_offset[tbox_page];
		
		//Drawing the Right VDU 
		
		draw_sprite_ext(sprite_index, image_index,_rightvdu_x, _rightvdu_y,1,1,0,c_white,1); // Drawing Right VDU Contents
		draw_sprite_ext(tbox_rvdu_border_flicker, tbox_rvdu_border_flicker_speed,_rightvdu_x, _rightvdu_y,1,1,0,c_white,0.2); // Drawing Right VDU Flicker
		draw_sprite_ext(tbox_rvdu_border, tbox_rvdu_border_image,_rightvdu_x, _rightvdu_y,1,1,0,c_white,1); // Drawing the Border
		
			
		
	}

//----- Draw the textbox background. 

draw_sprite_ext(tbox_sprite[tbox_page], tbox_image, _tbox_x, _tbox_y, tbox_width/tbox_sprite_w,tbox_height/tbox_sprite_h,0,c_white,1);

//----- Options. 

if tbox_draw_char == tbox_text_length[tbox_page] && tbox_page == tbox_page_number -1
	{
		
		//Option Selection. 
		option_pos += keyboard_check_pressed(global.down_key) - keyboard_check_pressed(global.up_key);
		option_pos = clamp(option_pos,0,option_number-1);
		
		
		// Draw the options. 
		var _op_space = 28; 
		var _op_border = 12;
		var _c = c_fuchsia;
		for (var op = 0; op < option_number; op++)
			{
				
				//Option Box
				var _o_width = string_width(option[op]) + _op_border*2; 
				draw_sprite_ext(tbox_sprite[tbox_page], tbox_image, _tbox_x+16, _tbox_y - _op_space*option_number + _op_space*op-6 , _o_width/tbox_sprite_w+1, ((_op_space-1)/tbox_sprite_h),0,c_white,1)
				
				//Selection Arrow 
				if option_pos == op
					{
						
						draw_sprite(spr_menuarrow,-1,_tbox_x+18, _tbox_y - _op_space*option_number + _op_space*op);
						
					}
				
				//Draw Option Text
				draw_text_color(_tbox_x + 18 +  _op_border, _tbox_y - _op_space*option_number + _op_space*op,option[op],_c,_c,_c,_c,1);
			}
		
	}

//----- Draw the text! 
for(var c = 0; c < tbox_draw_char; c++)
	{
		//Text!
		draw_text_color( char_x[c, tbox_page]-22, char_y[c, tbox_page], char[c, tbox_page],c1[c, tbox_page],c2[c, tbox_page],c3[c, tbox_page],c4[c, tbox_page],1);
	}
