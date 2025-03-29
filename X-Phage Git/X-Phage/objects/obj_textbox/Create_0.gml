/// @description Insert description here
// You can write your code in this editor

// TEXTBOX PARAMETERS // 

depth = -9999;										// Ensures the textbox is ALWAYS drawn on top.
tbox_width = 488;									// Width should fit snugly between portraits on game-HUD
tbox_height = 60;									// Height is same as game-portraits, 64px.
tbox_border = 8;									// Border between edge of box and text.

tbox_line_spacing = 8;								// 8px of spacing between 'spaces'. 
tbox_line_width = tbox_width - tbox_border*2 -16;   // Spacing between lines -- Should be -16 to prevent overlap.

tbox_lvdu_border_flicker[0] = 0;					// Left VDU Flicker Effect
tbox_lvdu_border_flicker_speed = -1;				// Left VDU Flicker Effect Animation Speed 
tbox_lvdu_border = spr_LeftVDU;						// Left VDU Flicker Effect Sprite
tbox_lvdu_border_image = 0;							// Left VDU Flicker Effect Sprite Starting-Frame (Which should be zero.)
//tbox_lvdu_border_image_speed = 0;					// Left VDU Flicker Effect Sprite Animation-Speed (Which should be zero.)

tbox_rvdu_border_flicker = spr_BlueStatic;			// Right VDU Flicker Effect
tbox_rvdu_border_flicker_speed = -1;				// Right VDU Flicker Effect Animation Speed 
tbox_rvdu_border = spr_RightVDU;					// Right VDU Flicker Effect Sprite
tbox_rvdu_border_image = 0;							// Right VDU Flicker Effect Sprite Starting-Frame (Which should be zero.)
//tbox_rvdu_border_image_speed = 0;					// Right VDU Flicker Effect Sprite Animation-Speed (Which should be zero.)
tbox_sprite[0] = spr_menu;
tbox_image = 0;
tbox_image_speed = 0; 


// TEXTBOX TEXT VARIALBES // 

tbox_page = 0;										// What Page of Dialogue are we on? 
tbox_page_number = 0;                               // Gathers page-number based on tbox_text array entry number.
tbox_text[0] = "";									// Text that Displays on the Textbox
tbox_text_length[0] = string_length(tbox_text[0]);  // Determines how long each string of dialogue is, based on amount of characters.

char[0,0] = ""; 
char_x[0,0] = 0;
char_y[0,0] = 0;

tbox_draw_char = 0;									// How many characters are being drawn currently.




// TEXTBOX OPTIONS // 

option[0] = ""; 
option_link_id[0] = -1; 
option_pos = 0; 
option_number = 0; 



tbox_setup = false; // False as default, if no textbox is on-screen.


// SOUND //

snd_delay = 4;			// 4-Tick Delay between text-box sounds, to keep from deafening the player with stacking audio.
snd_count = snd_delay;  // Resets the timer back to 4 ticks once each sound has played.

// TEXTBOX EFFECTS // 

scr_set_text_defaults();
last_free_space = 0; 
text_pause_timer = 0; 
text_pause_time = 32;


//////////////////////////////////////////////////////////////////////////




