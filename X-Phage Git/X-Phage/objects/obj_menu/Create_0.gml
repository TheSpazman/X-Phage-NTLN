/// @description Display the Tilescreen Menu -- Recoded

// Menu Script -- 2/24/24



// VARIABLES 
width = 128;								//Width of Menu Window
height = 160;								//Height of Menu Window
op_border = 8;								//Menu Window Margins
op_space = 16;								//Space Between Window Options
select = 0;									//Set Cursor Position at 0 / Start
menu_level = 0;								//Current Menu Level
textColor1 = c_aqua;                        //Unselected Text 
textColor2 = c_yellow;						//Selected Text
vS = 20;									//Vertical Space between Menu Entries
lastmx = 0;                                 //Last Known X Mouse Position
lastmy = 0;									//Last Known Y Mouse Position

		

// MOUSE CONTROL DETECTION / FUNCTION

mouse_c = true; 

var gp_num = gamepad_get_device_count();
var i; 
for  (var i = 0; i < gp_num; i++;)
{
	if gamepad_is_connected(i) mouse_c = false; 
}

mxPrev = device_mouse_x_to_gui(0);			//Original Mouse Position X
myPrev = device_mouse_y_to_gui(0);			//Original Mouse Position Y

// Sub Menu 0 -- Main Menu

option[0][0] = "Start";						
option[0][1] = "Settings";
option[0][2] = "Information"; 
option[0][3] = "Quit"; 

// Sub Menu 1 -- Game Menu 

option[1][0] = "Begin a New Adventure";		
option[1][1] = "Load a Saved Adventure"; 
option[1][2] = "Delete a Saved Adventure"; 
option[1][3] = "Return to Previous"; 

// Sub Menu 2 -- Settings Menu 

option[2][2] = "Toggle Fullscreen"; 
option[2][3] = "Return to Previous"; 

// Sub Menu 3 -- Game Info 

op_length = array_length(option);			//Length of Options String


