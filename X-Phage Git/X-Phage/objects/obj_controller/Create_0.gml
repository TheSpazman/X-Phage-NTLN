/// @description Game Controller w/ Global Variables

// GLOBALS 

controls_setup();

// IS GAME PAUSED? 

global.pause = false; 

// SET GAME FONTS 

global.font_main = font_add_sprite(spr_main_font, 32, true, 1);
global.font_numb = font_add_sprite(spr_HUD_font, 32, true, 1); 
global.tbox_text_speed = 0.5;							// Global Text-Typing Speed

// SET PLAYER CURSOR GRAPHIC HERE 

global.cursor = spr_cursor1;

enum cursor_types
{
	pointer,
	pointer_interact,
	neutral,
	interact,
	hostile,
}

// MENU-RELATED RESOLUTION VARIABLES

global.view_width					= camera_get_view_width(view_camera[0]);
global.view_height					= camera_get_view_height(view_camera[0]);

//////////////////////////////////////////////////////////////////////////////
// KEYBINDS																	//
//////////////////////////////////////////////////////////////////////////////

get_controls();

//////////////////////////////////////////////////////////////////////////////
// SET GAME RESOLUTION TO CHOSEN OPTIONS-MENU PARAMETERS                    //
//////////////////////////////////////////////////////////////////////////////

display_set_gui_size(global.view_width, global.view_height); 

//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
// MENU TYPES, TREES, PAGES AND INFORMATION ENUMERATORS / ARRAYS            //
//////////////////////////////////////////////////////////////////////////////

enum menu_page 
{
	main		, 
	game		,
	settings	,
	audio		,
	display	    ,
	controls	,
	keyboard	,
	//mouse	    ,
	gamepad 	,
	quit		,
	height      ,
	
}

enum menu_type
{
	menu_transfer	,
	script_trigger	,
	slider			,
	shift			,
	toggle			,
	input			,
			
	
}

////////////////////////////////////////////////////////////

// CREATING MENU PAGES 

ds_menu_main = create_menu_page(  // MAIN MENU
	["Start",									menu_type.menu_transfer,	menu_page.game],
	["Settings",								menu_type.menu_transfer,	menu_page.settings],
	["Information",								menu_type.script_trigger,	game_information],
	["Quit",									menu_type.menu_transfer,	menu_page.quit], 
);												
												
ds_menu_game = create_menu_page(  // GAME MENU
	["Record New Genetic Timestamp",			menu_type.script_trigger,	new_game],
	["Load Existing Genetic Timestamp",			menu_type.script_trigger,	load_game],
	["Delete Existing Genetic Timestamp",		menu_type.script_trigger,	delete_game],
	["Return to Previous Menu",					menu_type.menu_transfer,	menu_page.main], 
);

ds_menu_settings = create_menu_page( // SETTINGS MENU
	["Audio",									menu_type.menu_transfer,	menu_page.audio],
	["Controls",								menu_type.menu_transfer,	menu_page.controls],
	["Display",									menu_type.menu_transfer,	menu_page.display],
	["Return to Previous Menu",					menu_type.menu_transfer,	menu_page.main], 
);

ds_menu_audio = create_menu_page( // AUDIO MENU
	["Master Volume",							menu_type.slider,	change_volume,  0.5, [0,1]],
	["Music Volume",							menu_type.slider,	change_volume,  0.5, [0,1]],
	["Sound Volume",							menu_type.slider,	change_volume,  0.5, [0,1]],
	["Return to Previous Menu",					menu_type.menu_transfer,	menu_page.settings], 
);

ds_menu_controls = create_menu_page( // CONTROLS MENU
	["Keyboard",								menu_type.menu_transfer,	menu_page.keyboard		 ],
//	["Mouse",									menu_type.menu_transfer,	menu_page.mouse			 ],
	["Gamepad",									menu_type.menu_transfer,	menu_page.gamepad		 ],
	["Return to Previous Menu",					menu_type.menu_transfer,	menu_page.settings		 ], 
);

ds_menu_keyboard = create_menu_page( // KEYBOARD CONTROLS MENU
	["Fire Weapon",							menu_type.input,	"primary_fire_key",		ord("L")     ],
	["Interact / Action",					menu_type.input,	"secondary_fire_key",	ord("E")     ],
	["Confirm",							    menu_type.input,    "confirm_key",          vk_enter     ],
	["Cancel",								menu_type.input,    "cancel_key",			vk_backspace ],
	["Up",									menu_type.input,	"up_key",				ord("W")     ],
	["Down",								menu_type.input,	"down_key",				ord("S")     ],
	["Left",								menu_type.input,	"left_key",				ord("A")     ],
	["Right",								menu_type.input,	"right_key",			ord("D")     ],
	["Inventory",							menu_type.input,	"inven_key",			ord("I")     ],
	["Run (Held)",							menu_type.input,	"run_key",				vk_shift     ],
	["Jump / Wingpack",						menu_type.input,	"jump_key",				vk_space     ],
	["Weapon Select (Up)",					menu_type.input,	"weapon_up_key",		vk_pageup    ],
	["Weapon Select (Down)",				menu_type.input,	"weapon_down_key",		vk_pagedown  ],
	["Always Run",							menu_type.toggle,	always_run,		0,		["Off", "On"]],
	["Return to Previous Menu",				menu_type.menu_transfer,	menu_page.controls			 ], 
);

//ds_menu_mouse = create_menu_page( // MOUSE CONTROLS MENU
//	["Fire Primary Weapon",					menu_type.input,	"primary_fire_key",		mb_left      ],
//	["Fire Secondary Weapon",				menu_type.input,	"secondary_fire_key",	mb_right     ],
//	["Return to Previous Menu",				menu_type.menu_transfer,	menu_page.controls			 ], 
//);

ds_menu_gamepad = create_menu_page( // GAMEPAD CONTROLS MENU
	["Action / Confirm",                     menu_type.input,    "confirm_key_pad",					     ],
	["Up",									menu_type.input,	"up_key_pad",						     ],
	["Down",								menu_type.input,	"down_key_pad",						     ],
	["Left",								menu_type.input,	"left_key_pad",						     ],
	["Right",								menu_type.input,	"right_key_pad",					     ],
	["Inventory",							menu_type.input,	"up_key_pad",						     ],
	["Jump / Wingpack",						menu_type.input,	"jump_key_pad",						     ],
	["Weapon Select (Up)",					menu_type.input,	"weapon_up_key_pad",				     ],
	["Weapon Select (Down)",				menu_type.input,	"weapon_down_key_pad",					 ],
	["Return to Previous Menu",				menu_type.menu_transfer,	menu_page.controls				 ], 
);

ds_menu_display = create_menu_page( // DISPLAY MENU
	["Set Windowed Resolution",                 menu_type.shift,    change_resolution,  0, ["640x400 (Default)", "1280x800 (Doubled)", "1920x1200 (2.5x)"]],
	["Toggle Fullscreen",						menu_type.toggle,	toggle_fullscreen,  1, ["Windowed", "Fullscreen"]],
	["Toggle Borders",							menu_type.toggle,	toggle_borders,		1, ["Borderless", "Bordered"]],
	["Text Speed",								menu_type.shift,	text_speed,			0, ["Slow","Normal","Fast","Instant"]],
	["Return to Previous Menu",					menu_type.menu_transfer,	menu_page.settings], 
);

ds_menu_quit = create_menu_page( // VERIFY QUIT MENU
	["Cancel",								menu_type.menu_transfer,						menu_page.main], 
	["Confirm",								menu_type.script_trigger,							exit_game], 

);



page = 0; 
menu_pages = [ds_menu_main, ds_menu_game, ds_menu_settings, ds_menu_audio, ds_menu_display, ds_menu_controls, ds_menu_keyboard, ds_menu_gamepad, ds_menu_quit];

var i = 0, array_len = array_length(menu_pages);

	repeat(array_len)
	{
		menu_option[i] = 0;
		i++;
	}

inputting = false; 

audio_group_load(xp_music);
audio_group_load(xp_sfx);


