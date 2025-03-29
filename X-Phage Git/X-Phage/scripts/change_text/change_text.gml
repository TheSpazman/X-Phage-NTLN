

///These functions handle most of the speech / dialogue system!  
	
function scr_set_text_defaults()								// SET DEFAULTS FOR THE DIALOGUE-SYSTEM. 
	{
		line_break_pos[0, tbox_page_number] = 999;				// LINE-BREAK POSITION IS ZEROED
		line_break_num[tbox_page_number] = 0;					// NUMBER OF LINE-BREAKS IS ZEROED
		line_break_offset[tbox_page_number] = 0;				// LINE-BREAK OFFSET IS ZEROED
		
		//variables for every letter / character
		for (var c = 0; c < 400; c++)							// FOR EVERY CHARACTER (MAX IS 400 CHARACTERS), DO THIS: 
			{
				c1[c, tbox_page_number] = c_aqua;				// DEFAULT COLOR IS AQUA 
				c2[c, tbox_page_number] = c_aqua;				// DEFAULT COLOR IS AQUA 
				c3[c, tbox_page_number] = c_aqua;				// DEFAULT COLOR IS AQUA 
				c4[c, tbox_page_number] = c_aqua;				// DEFAULT COLOR IS AQUA 
			}
		
		
		
		tbox_sprite[tbox_page_number] = spr_menu;				// TEXTBOX SPRITE 
		left_vdu_sprite[tbox_page_number] = noone;				// LEFT VDU 
		tbox_lvdu_border_flicker[tbox_page_number] = noone;     // Left VDU Flicker Effect
		right_vdu_sprite[tbox_page_number] = noone;				// RIGHT VDU 
		snd[tbox_page_number] = snd_textbeep;					// TEXTBOX TEXT-SOUND 
	}


//----- TEXT VFX -----------//
/// @param 1st_char
/// @param last_char
/// @param 1st_color
/// @param 2nd_color
/// @param 3rd_color
/// @param 4th_color
function scr_text_color(_start, _end,_col1,_col2,_col3,_col4){ // THIS SCRIPT CHANGES TEXT-COLOR FOR THE DIALOGUE SYSTEM

for (var c = _start; c <= _end; c++)
	{
		c1[c, tbox_page_number-1] = _col1;	// THESE ARE DEFINED ABOVE IN DEFAULTS.
		c2[c, tbox_page_number-1] = _col2;
		c3[c, tbox_page_number-1] = _col3;
		c4[c, tbox_page_number-1] = _col4;
	}


}

/// @param text
/// @param [leftVDU]
/// @param [rightVDU]
function change_text(_text) // CHANGE GAME-TEXT USING THIS FUNCTION! 
{				

	scr_set_text_defaults();
	
	tbox_text[tbox_page_number] = _text; 
	
	
	if argument_count > 1							// ADD DIFFERENT PORTRAITS + TEXTBOX SPRITES + SOUNDS USING THIS! 
		{
			switch(argument[1]) // FIRST ARGUMENT DISPLAYS PORTRAIT ON LEFT / RED BOX
				{
					//KA'DIN SA'KARAN
					
					case "kadinneutral" :			// KA'DIN NEUTRAL + NOT-SPEAKING SPRITE.
						left_vdu_sprite[tbox_page_number] = spr_KadinTboxNeutral;
						tbox_lvdu_border_flicker[tbox_page_number] = spr_RedStatic;                 // LEFT VDU FLICKER SPRITE
						tbox_sprite[tbox_page_number] = spr_menu;
						snd[tbox_page_number] = snd_textbeep;
						break;
					
					// LEON NISITALIA + LE'YN NYSITALIA
					
				}
			switch(argument[2]) // SECOND ARGUMENT DISPLAYS PORTRAIT ON RIGHT / BLUE BOX
				{
					case "leonneutral":				// LEON NEUTRAL + NOT-SPEAKING SPRITE. 
						right_vdu_sprite[tbox_page_number] = spr_LeonTboxNeutral;
						tbox_sprite[tbox_page_number] = spr_menu;
						snd[tbox_page_number] = snd_textbeep;
					break;
				}
		}
	
	
	
	tbox_page_number++; 

}

/// @param option
/// @param link_id
function scr_option(_option, _link_id) // THIS DISPLAYS AN OPTIONS-SELECTOR ABOVE THE TEXT! 
	{
		
		option[option_number] = _option; 
		option_link_id[option_number] = _link_id;
		
		option_number++; 
		
	}

/// @param text_id
function create_textbox(_text_id)		// THIS CREATES AND DISPLAYS A TEXTBOX WITH GIVEN TEXT USING TEXT-ID.
	{
		with(instance_create_depth(0,0,-9999,obj_textbox))
			{
				game_text(_text_id);
			}
	}