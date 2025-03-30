#region COYOTE TIME 

	#region	COYOTE TIME FUNCTIONS

//--- PLAYER-SPECIFIC FUNCTIONS ---//
function setOnGround(_val = true)
{
	if _val == true
		{
			onGround = true;
			coyoteHangTimer = coyoteHangFrames;
		} else {
			onGround = false;
			coyoteHangTimer = 0;
		}
}

#endregion

	#region COYOTE TIME VARIABLES

//---	COYOTE TIME VARIABLES ---// 

coyoteHangFrames	= 5;		// # of frames Coyote Time is active (Off Ledge)
coyoteHangTimer		= 0;		// Countdown of frames while CT is active (Off Ledge)

//---   C.T. BUFFER  ---//

coyoteJumpFrames	= 10;		// # of frames Coyote Time is active (Jump)
coyoteJumpTimer		= 0;		// Countdown of frames while CT is active (Jump)

//////////////////////////
#endregion

#endregion

#region PLAYER JUMP FUNCTIONS + CONTROLS SETUP

controls_setup(); // CONTROLS SETUP 

#endregion 

#region PLAYER ANIMATION

//--- INITIALIZING UNIVERSAL ANIMATION SYSTEM ---// 

animInit();

//--- CHARACTER SPRITE VARIABLES + STATES ---// 

enum playerStates{

	idle,
	rise,
	jump,
	fall,
	land,
	walk,
	run,

}

playerState = playerStates.idle;											// Player Initialization State

animAddAnim("IDLE",noone,noone,1,0,0,spr_KaDinIdle);						// Player Idle Anim
animAddChainedAnim("RISING",1,1,1,0,7,spr_KaDinRising,1,"FLYING");			// Player Rising + Begin Jump Anim
animAddAnim("FLYING",1,1,1,0,9,spr_KaDinJump);								// Player Mid-Flight Anim
animAddAnim("LANDING",1,1,1,0,7,spr_KaDinLanded);							// Player Landing Anim
animAddAnim("WALKING",1,1,1,0,17,spr_KaDinWalk);							// Player Walk Anim
animAddAnim("RUNNING",1,1,1,0,17,spr_KaDinRun);								// Player Run Anim
animAddAnim("FALLING",1,1,1,0,9,spr_KaDinFalling);							// Player Falling Anim

animSet("IDLE");

#endregion

#region PLAYER VARIABLES 

	#region DIRECTIONAL MOVEMENT
//---  MOVEMENT ---// 
depth				= 300;
playerCanMove       = 1;        // Enables / Disables character-movement + Physics. Useful during cutscenes.
playerCanShoot      = 1;        // Enables / Disables character weapons-fire.
playerFacing        = 1;		// What direction is the player facing? 1 for right, -1 for left.
playerDirection		= 0;		// What direction is the player moving? 1 for right, -1 for left.
runType				= 0;		// This becomes 1 if the Run-Key is held down.
playerAccel			= 0.3;		// New Acceleration code from old version of X-Phage.
playerFriction      = 0.7;      // New Friction code from old version of X-Phage.
playerSpeed[0]		= 4;		// Player Walk-Speed.
playerSpeed[1]      = 6;		// Player Run-Speed. 
xSpeed				= 0;		// Current X-Speed.
ySpeed				= 0;		// Current Y-Speed.

playerFootstep      = 0;		// Timer for Walk / Run-Animation Footstep Sound. 

wingpackSound       = 0;        // Timer for Wingpack Boost SFX! 
wingpackExhaust     = 0;		// Timer for Wingpack Exhaust Sprite!
//wingpackLiftoff     = 0;		// Timer for Wingpack Liftoff Sprite

#endregion

	#region JUMP CONTROLS

//--- JUMP CONTROL VARIABLES ---// 
grav				= .3;		// Gravity
termVel				= 7;		// Terminal Velocity
jumpMax				= 1;		// Max # of times player can jump. 
jumpCount			= 0;		// # of jumps player has performed. 
jumpHoldTimer		= 0;		// How many frames Jump-button has been held. 
jumpHoldFrames[0]	= 12;		// Max # of frames jump-button can be held.
jumpSpeed[0]		= -6;		// Player Jump-Speed. 
onGround			= true;		// Is the player grounded? 1 / true for yes, 0 / false for no. 

#endregion



	#region PLAYER HUD VALUES 
//--- VITALS AND VALUES ---// 

// Vitality + Resolve 

playerVitality = 99;			// Player's Current Vitality (Health)
playerVitalityMax = 99;			// Player's Max Vitality (Health)
playerResolve = 99;				// Player's Current Resolve (Mana / Armor)
playerResolveMax = 99;			// Player's Max Resolve (Mana / Armor)

playerVitalityString = string(playerVitality);	// Vitality value displayed on HUD 
playerResolveString = string(playerResolve);	// Resolve value displayed on HUD 

// GEMS Balance (Money) 

gemsBalance = 0; 

// Wingpack Jump Fuel 

playerJumpFuel = 99;							// Player's Current Jump-Fuel 
playerJumpFuelMax = 99;							// Player's Max Jump-fuel
playerJumpFuelLossRate = 18;					// Jump Fuel Rate-of-Loss
playerJumpFuelRegenRate = 4;					// Jump Fuel Rate of Regen

playerJumpFuelString = string(playerJumpFuel);  // Jump Fuel value displayed on HUD 

/////////////////////////////

#endregion

	#region PLAYER ATTACK

// Attacking

playerFireDelay = 0;             // Ticks in Countdown Timer
playerFireMaxDelay = 15;         // # of ticks to reset before next attack


////////////////////////////
#endregion

#endregion

















