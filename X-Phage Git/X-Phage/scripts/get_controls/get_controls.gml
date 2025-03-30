function controls_setup(){
	

jumpBufferTime			= 5; 
						  
jumpKeyBuffered			= 0; 
jumpKeyBufferTimer		= 0; 

}

function get_controls(){

// ENTER / CANCEL KEYS 

global.confirm_key					= vk_enter;
global.cancel_key					= vk_backspace;
global.pause_key					= vk_escape;

// U/D/L/R CONTROLS

global.up_key						= ord("W"); 
global.down_key						= ord("S"); 
global.left_key						= ord("A"); 
global.right_key					= ord("D");


// RUN + JUMP (and other locomotion) CONTROLS

global.run_key						= vk_shift; 
global.jump_key						= vk_space; 

// ITEM AND INVENTORY-RELATED CONTROLS 

global.weapon_up_key				= vk_pageup;
global.weapon_down_key				= vk_pagedown;
global.inventory_key				= ord("I"); 

// WEAPONS-FIRE / COMBAT-RELATED CONTROLS 

global.primary_fire_key				= ord("L");
global.secondary_fire_key			= ord("E");

// PLAYER CONTROLS AND CLAMPS // 

// Directional

rightKey							= keyboard_check(global.right_key);
	rightKey						= clamp( rightKey, 0, 1 );

leftKey								= keyboard_check(global.left_key);
	leftKey							= clamp( leftKey, 0, 1 );


// Action

jumpKeyPressed						= keyboard_check_pressed(global.jump_key);
	jumpKeyPressed					= clamp( jumpKeyPressed, 0, 1 ); 
	
jumpKey								= keyboard_check(global.jump_key);
	jumpKey							= clamp( jumpKey, 0, 1 );
	
runKey								=keyboard_check(global.run_key);
	runKey							= clamp( runKey, 0, 1 ) ;
	
// Firing 

fireKey								= keyboard_check_pressed(global.primary_fire_key);
	fireKey							= clamp( fireKey, 0,1 );
	
	
// Jump-Key Buffering

if jumpKeyPressed
	{
		jumpKeyBufferTimer = jumpBufferTime;
	}
	
if jumpKeyBufferTimer > 0 
	
	{
		jumpKeyBuffered = 1;
		jumpKeyBufferTimer--;
		
	} else {
		
		jumpKeyBuffered = 0; 	
		
	}
}