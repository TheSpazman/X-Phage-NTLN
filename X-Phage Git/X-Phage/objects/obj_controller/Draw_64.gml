






// IF THE GAME IS PAUSED, THESE SCRIPTS SHOULD NOT FUNCTION. // 

window_set_caption("X-Phage: Sci-Fi Cyberpunk Adventure");

if (!global.pause) exit;

// DRAW MAIN / PAUSE MENU AND ELEMENTS // 

// SETTING OPTIONS-MENU CURSOR HERE // 

window_set_cursor(cr_none); 
cursor_sprite = (global.cursor); 

// SIZE AND SETUP VARIABLES FOR SETTING UP PAUSE / MAIN MENU // 

var gwidth = global.view_width;      // H/W FOR THE GAME'S WINDOW SIZE 
var gheight = global.view_height;  

var ds_grid = menu_pages[page];      // GRID SHOULD CONSIST OF MENU PAGES DEFINED IN CREATE SCRIPT, H/W 
var ds_height = ds_grid_height(ds_grid);

var y_buffer = 20;					// SPACE BETWEEN EACH MENU OPTION, ON X/Y PLANE
var x_buffer = 16;

var start_y = (gheight/2) - ((((ds_height-1)/2) * y_buffer));  // STARTING LOCATION OF TEXT-STRINGS, ON X/Y PLANE
var start_x = gwidth/2;

//var menu_pos_x = 320;
//var menu_pos_y = 200;

// MENU RENDERING SCRIPT + VARIABLES

// DRAWING THE STRETCHED / TESSELATED BACKGROUND FOR THE MAIN / PAUSE MENU // 

var c = c_white
var menu_pos_x   = 0;
var menu_pos_y   = 0;
var menu_scale_w = 640;
var menu_scale_h = 400;

var crest_pos_x  = 16;
var crest_pos_y  = 16;
image_speed = 0.2;


draw_sprite_stretched(spr_menu,image_index,menu_pos_x,menu_pos_y,menu_scale_w,menu_scale_h);
draw_sprite_stretched_ext(spr_crest1, image_index, crest_pos_x, crest_pos_y, 32, 32,c_white,0.5);

// SILLY COPYRIGHT THING FOR THE MENU // 

var copyright_x = 316;
var copyright_y = 384;
draw_text_color(copyright_x, copyright_y, "X-Phage WIP Version -- 01.08.2025, by Spaz",c_aqua,c_aqua,c_aqua,c_aqua,0.5);
	
// DRAW MENU ITEMS ON LEFT SIDE 

draw_set_font(global.font_main);
draw_set_valign(fa_middle);
draw_set_halign(fa_right);

var ltx = start_x - x_buffer;  // LTX / LTY DEFINE MARGINS WHEN PREPARING TO DRAW TEXT 
var lty;
var xo;

var yy = 0;

	repeat(ds_height)
	{
		var _c = c_aqua;
		xo = 0;
		
		if(yy == menu_option[page]) 
			{ 
				_c = c_fuchsia     // DRAW CURRENTLY-SELECTED MENU ENTRY IN A DIFFERENT COLOR..
				xo = -(x_buffer/2);  // SHIFTS CURRENT MENU ENTRY TO THE LEFT WHEN SELECTED..
				var select_arrow = ">> "; // .. THEN APPLIES ARROW INDICATORS.
			}
		else 
			{
		select_arrow = "";        // OTHERWISE, IF UNSELECTED, DO NOT DRAW ARROWS.
			}
			
		lty = start_y + (yy * y_buffer);
		draw_text_color(ltx+xo, lty,(select_arrow + ds_grid[# 0, yy]), _c,_c,_c,_c, 1);  // THEN, PROCEED TO DRAW TEXT STRINGS FROM DS_GRID
		yy++;
	}
	

////////////////////////////////////////////////////////////////

// DRAW DIVIDING LINE 

draw_line_color(start_x, start_y, start_x,lty, c_aqua, c_aqua);

////////////////////////////////////////////////////////////////

// DRAW RIGHT-SIDE ELEMENTS

draw_set_halign(fa_left);

var rtx = start_x + x_buffer;
var rty;

yy = 0; 

repeat(ds_height)
	{
		rty = start_y + (yy*y_buffer);
		
		switch(ds_grid[# 1, yy])
			{
				case menu_type.shift:
					{
						var current_val = ds_grid[# 3, yy];
						var current_val_words = ds_grid[# 4, yy];
						var left_indicator = "<< ";
						var right_indicator = " >>"; 
						
						c = c_aqua;
						
						if(current_val == 0) left_indicator = "";
						if(current_val == array_length(ds_grid[# 4, yy])-1) right_indicator = "";
						
						
						
						if(inputting and yy == menu_option[page]) {c = c_fuchsia;} 
						
						draw_text_color(rtx, rty, (left_indicator + current_val_words[current_val] + right_indicator), c,c,c,c, 1);
						
						break;
					}
			
				case menu_type.slider: 
					{
						var len = 64; 
						var current_val = ds_grid[# 3, yy];
						var current_array = ds_grid[# 4, yy]; 
						var circle_pos = ((current_val - current_array[0]) / (current_array[1] - current_array[0]));
						c = c_aqua;
						
						draw_line_width_color(rtx, rty, (rtx + len), rty, 2, c, c);
						
						if(inputting and yy == menu_option[page]) {c = c_fuchsia;} 
						
						draw_circle_color(rtx + (circle_pos * len), rty, 4,c,c, false);
						
						draw_text_color(rtx + (len*1.2), rty, string(floor(circle_pos*100))+"%",c,c,c,c,1);
						
						
						break;
					}
					
				case menu_type.toggle: 
					{
						c = c_aqua;
						var current_val = ds_grid[# 3, yy];
						var c1;
						var c2; 
						
						
						if(inputting and yy == menu_option[page]) {c = c_fuchsia;} 
						
						if(current_val == 0)
							{
								c1 = c; c2 = c_blue;
							}
						else
							{
								c1 = c_blue; c2 = c;
							}
							
						draw_text_color(rtx,rty, "ON", c1,c1,c1,c1,1);
						draw_text_color(rtx + 32,rty, "OFF", c2,c2,c2,c2,1);
						
						break;
					}
				
				case menu_type.input: 
					{
						var current_val = ds_grid[# 3, yy]; 
						
						switch(current_val)
							{
								case vk_enter:			string_val = "ENTER KEY"; break;
								case vk_shift:			string_val = "SHIFT KEY"; break;
								case vk_space:			string_val = "SPACEBAR"; break;
								case vk_pagedown:		string_val = "PAGE UP"; break; 
								case vk_pageup:			string_val = "PAGE DOWN"; break; 
								case mb_left:           string_val = "LEFT MOUSE BUTTON"; break; 
								case mb_right:			string_val = "RIGHT MOUSE BUTTON"; break; 
								case vk_up:				string_val = "UP ARROW"; break;
								case vk_down:			string_val = "DOWN ARROW"; break;
								case vk_left:			string_val = "LEFT ARROW"; break;
								case vk_right:			string_val = "RIGHT ARROW"; break;
								case vk_backspace:      string_val = "BACKSPACE"; break;
								case vk_control:		string_val = "CONTROL"; break;
								case vk_alt:            string_val = "ALT"; break;
								default:				string_val = chr(current_val); break; 
							}
							
						c = c_aqua;
						
						if(inputting and yy == menu_option[page]) {c = c_fuchsia;} 
						
						draw_text_color(rtx, rty, string_val, c,c,c,c,1); 
						
					}
			}
		yy++;
	}



draw_set_valign(fa_top);



//
