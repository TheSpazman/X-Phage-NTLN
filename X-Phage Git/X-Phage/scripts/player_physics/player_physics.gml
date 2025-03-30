
// WARNING: THIS IS OLD CODE FROM THE ORIGINAL VERSION OF X-PHAGE -- WORK IS BEING DONE TO MAKE THIS CODE USABLE. 

// THIS NOW INCLUDES THE FUNCTIONS FOR THE PLAYER'S ANIMATION CODE. 


function player_physics_normal(){
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//--- X-MOVEMENT ---// 
	
	// If Paused // 
	
	if instance_exists(obj_pauser) { xSpeed = 0; ySpeed = 0; playerAccel = 0;} else { playerAccel = 0.3 }
	
	// Direction // 
	
	playerDirection = rightKey - leftKey;
	
	// Get Player Facing // 
	
	if playerDirection != 0 { playerFacing = playerDirection };
	
	// Get X-Speed // 
	
	runType = runKey;
	
	// X-SPEED / ACCELERATION / FRICTION SCRIPTING // 

	if playerDirection != 0 
	
	{
		if (playerDirection == 1) xSpeed = min(playerSpeed[runType], xSpeed + playerAccel);						//accelerate going right
		if (playerDirection == -1) xSpeed = max(-playerSpeed[runType], xSpeed - playerAccel);					//accelerate going left
	}    
	
	else 

	{
		if (xSpeed > 0) xSpeed = max(0, xSpeed - playerFriction);												//friction going right
		if (xSpeed < 0) xSpeed = min(0, xSpeed + playerFriction);												//friction going left
	}
	
	// X-Collision // 
	
	var _subPixel = .5; 
	if place_meeting ( x + xSpeed, y, obj_wall ) 
		{
			// Check for upwards slope //
			
			if !place_meeting( x + xSpeed, y - abs(xSpeed)-1, obj_wall)
				{
					while place_meeting(x + xSpeed, y, obj_wall) { y-= _subPixel;};
				}
			else 
				{
			
					// Collide with wall pixel-perfect. //
					
					var _pixelCheck = _subPixel * sign(xSpeed); 
					while !place_meeting( x + _pixelCheck, y, obj_wall )
						{
							x += _pixelCheck; 
						}
					
					// X-Speed zeroes out on collision. //
					
					xSpeed = 0; 
				}
		}
	
	// Move Down Slopes //
	
	if ySpeed >= 0 && !place_meeting( x + xSpeed, y+1, obj_wall) && place_meeting(x + xSpeed, y + abs(xSpeed)+1, obj_wall)
	{
		while !place_meeting(x + xSpeed, y + _subPixel, obj_wall) { y += _subPixel };
	}
	
	// Collision with Doors // 
	

	if (place_meeting( x + xSpeed, y, obj_testdoor))
		{
			
			var _pixelCheck = sign(xSpeed);
			while !place_meeting( x + _pixelCheck,y, obj_testdoor)
			{
				x+= _pixelCheck;
			}
			
			xSpeed = 0;
			
		
		}
		
	if (place_meeting( x+xSpeed, y+ySpeed, obj_testdoor))	
		{
		var _pixelCheck = sign(ySpeed);
			while !place_meeting( x + xSpeed,y, obj_testdoor)
			{
				y+= _pixelCheck;
			}
			
			ySpeed = 0;
		}
		
// Move // 
	
	x += xSpeed; 
		
//--- Y-MOVEMENT ---// 

	// Gravity //
	
	if coyoteHangTimer > 0
		{
			// Reduce the timer by 1 every tick // 
			
			coyoteHangTimer--;
		} else {
			// Apply gravity to the player. //
			
			ySpeed += grav;
			
			// We are no longer grounded. // 
			
			setOnGround(false);
		}
	
	// Reset + Prepare Jump (and Coyote-Time) Variables //
	
	if onGround
		{
			jumpCount = 0;
			coyoteJumpTimer = coyoteJumpFrames;
		}else{
			// Increases jump-count by 1 -- Disallow jump if max count and C.T Timer is reached. //
			
			coyoteJumpTimer--; 
			if jumpCount == 0 && coyoteJumpTimer <= 0 { jumpCount = 1; };
		}
	
	// Jump //
	
	if jumpKeyBuffered && jumpCount < jumpMax
		{
			// Reset buffer. //
			
			jumpKeyBuffered = false;
			jumpKeyBufferTimer = 0; 
			
			
			// Increase number of jumps performed. //
			
			jumpCount++;
			
			if !instance_exists(obj_WingpackLiftoff) { instance_create_depth(x,y,101,obj_WingpackLiftoff) }
			
			// Set jump-hold timer. //
			
			jumpHoldTimer = jumpHoldFrames[jumpCount-1]; 
			
			// No longer on the ground. //
			
			setOnGround(false);
		}
		// Cut off the jump by releasing the jump-button. //
		if !jumpKey
		{
			jumpHoldTimer = 0;
		}
		
		// Jump based on timer + button held. //
		
		if jumpHoldTimer > 0
		{
			// Constantly set Y to be jump-speed //
			
			ySpeed = jumpSpeed[jumpCount-1];
			// Count down timer //
			
			jumpHoldTimer--; 
		}
	
	// Y-Collision + Movement //
	
		// Falling-Speed Cap //
		
		if ySpeed > termVel { ySpeed = termVel; }; 
		
		// Collision // 
		
		var _subPixel = .5;
		if place_meeting(x , y+ySpeed, obj_wall)
			{
				
				// Collide with wall pixel-perfect. //
				
				var _pixelCheck = _subPixel * sign(ySpeed); 
				while !place_meeting( x , y+ _pixelCheck, obj_wall )
					{
						
						y += _pixelCheck; 
					
					}
					
		
					
				// Set Y-Speed to 0 on collision. // 
				
				ySpeed = 0; 
				
			}
			
				// Set if Player is on the ground. //
				if ySpeed >= 0 && place_meeting( x, y+1, obj_wall )
					{
						setOnGround(true);
					}
		
		// Move 
		
		y += ySpeed;

}

//-- ANIMATION SYSTEM STATE MACHINE --//

function kadinIdleState(){									// IDLE					   -- NO KEYED INPUT
	show_debug_message("Idle State");						
	//show_debug_message(xSpeed);
	//show_debug_message(ySpeed);
	wingpackSound = 0;
	animSet("IDLE");
	if ( playerDirection >= 1  || playerDirection <= -1 ) and (runType = 0){  // IF MOVING LEFT / RIGHT, AND RUN-KEY NOT-PRESSED
		playerState = playerStates.walk;									  // => WALK STATE
	}
	
	if ( playerDirection >= 1  || playerDirection <= -1 ) and (runType = 1){  // IF MOVING LEFT / RIGHT, AND RUN-KEY PRESSED
		playerState = playerStates.run;										  // => RUN STATE
	}
	
	if (jumpKeyPressed){													  // IF JUMP-KEY PRESSED,
		playerState = playerStates.rise;									  // => RISING STATE
		
	}
	
	if (!onGround) and (ySpeed > 0) {														  // IF PLAYER IS FALLING FOR ANY REASON
		playerState = playerStates.fall;									  // => FALLING STATE
	}

}

function kadinRisingState(){								// RISING -- START OF JUMP -- JUMP-BUTTON PRESSED
	show_debug_message("Rise State");
	//show_debug_message(xSpeed);
	//show_debug_message(ySpeed);
	animSet("RISING");
	
	if (jumpKey) and (image_index >= image_number-1){		// IF JUMP-KEY HELD AND RISING-ANIMATION FINISHES, 
		playerState = playerStates.jump;					// => JUMP / FLY STATE
	}
	
	else if (!jumpKey){											// IF JUMP-KEY RELEASED, 
		playerState = playerStates.fall;					// RETURN TO => IDLE STATE
	}
	
	
	
	if (sprite_index == spr_KaDinRising) and (wingpackSound = 0) 
	{
		audio_play_sound(snd_wingpack_start,8,false);
		
		wingpackSound = 20;
	}
	else if (wingpackSound > 0) { wingpackSound--; }
	
	if (sprite_index == spr_KaDinRising) and (wingpackExhaust = 0) 
	{
		
		if playerFacing = 1 
			{
				instance_create_depth((x-32),(y-5),101,obj_WingpackExhaust);
				wingpackExhaust = 5;
			} else if playerFacing = -1 {
				instance_create_depth((x+0),(y-5),101,obj_WingpackExhaust);
				wingpackExhaust = 5;
			}
	}
	else if (wingpackExhaust > 0) { wingpackExhaust--; }

}

function kadinJumpState(){									// JUMP / FLY              -- JUMP-BUTTON HELD
	show_debug_message("Jump State");
	//show_debug_message(xSpeed);
	//show_debug_message(ySpeed);
	animSet("FLYING");
	if (ySpeed >= 0) and (!onGround) {										// IF PLAYER BEGINS FALLING FOR ANY REASON
		playerState = playerStates.fall;					// => FALLING STATE
	}
	
	if audio_is_playing(snd_wingpack_start) { wingpackSound = 0; audio_stop_sound(snd_wingpack_start); } 
	
	if (sprite_index == spr_KaDinJump) and (wingpackSound = 0) 
	{
		audio_play_sound(snd_wingpack_flight,8,false);
		wingpackSound = 20;
	}
	else if (wingpackSound > 0) { wingpackSound--; }
	
	if (sprite_index == spr_KaDinJump) and (wingpackExhaust = 0) 
	{
		if playerFacing = 1 
			{
				instance_create_depth((x-32),(y-5),101,obj_WingpackExhaust);
				wingpackExhaust = 3;
			} else if playerFacing = -1 {
				instance_create_depth((x+0),(y-5),101,obj_WingpackExhaust);
				wingpackExhaust = 3;
			}
	}
	else if (wingpackExhaust > 0) { wingpackExhaust--; }
	
}

function kadinFallState(){									// FALLING				   -- JUMP-BUTTON RELEASED, GRAVITY IN EFFECT
	show_debug_message("Fall State");
	//show_debug_message(xSpeed);
	//show_debug_message(ySpeed);
	animSet("FALLING");
	
	if audio_is_playing(snd_wingpack_start) { 
		wingpackSound = 0; 
		audio_stop_sound(snd_wingpack_start); 
		
			if (sprite_index == spr_KaDinFalling) and (wingpackSound = 0) 
			{
				audio_play_sound(snd_wingpack_end,8,false);
				wingpackSound = 20;
			}
			else if (wingpackSound > 0) { wingpackSound--; }
		
		} 
	
	if audio_is_playing(snd_wingpack_flight) {
		wingpackSound = 0; 
		audio_stop_sound(snd_wingpack_flight);
		
		
			if (sprite_index == spr_KaDinFalling) and (wingpackSound = 0) 
			{
				audio_play_sound(snd_wingpack_end,8,false);
				wingpackSound = 20;
			}
			else if (wingpackSound > 0) { wingpackSound--; }
		
	} 
	
	if (ySpeed == 0) and (onGround) {
		playerState = playerStates.land;
	}

}

function kadinLandState(){									// LANDING				   -- PLAYER HITS GROUND, NO KEYED INPUT
	
	if (jumpKeyPressed){													  // IF JUMP-KEY PRESSED,
		playerState = playerStates.rise;									  // => RISING STATE
		
	}
	
	show_debug_message("Land State");
	//show_debug_message(xSpeed);
	//show_debug_message(ySpeed);
	animSet("LANDING");
	
	//if (ySpeed > 0){
	//	playerState = playerStates.fall;
	//}
	
	if sprite_index = spr_KaDinLanded and (image_index >= image_number-1) {
		playerState = playerStates.idle;
	}

	if (sprite_index == spr_KaDinLanded) and (image_index = 0) 
	{
		audio_play_sound(snd_footstep2,8,false);
		var footstepPitch = random_range(.95,1);
		audio_sound_pitch(snd_footstep2, footstepPitch);
	}
}

function kadinWalkState(){									// WALKING                 -- L/R DIRECTIONAL BUTTON INPUT
	
	show_debug_message("Walk State");
	//show_debug_message(xSpeed);
	//show_debug_message(ySpeed);
	animSet("WALKING");
	if(jumpKeyPressed){
		playerState = playerStates.rise;
	}
	
	if(!playerDirection) and (xSpeed = 0){
		playerState = playerStates.idle;
	}
	
	if ( playerDirection ) and (runType = 1){
		playerState = playerStates.run;
	}
	
	if (!onGround) and ( ySpeed > 0){														  // IF PLAYER IS FALLING FOR ANY REASON
		playerState = playerStates.fall;									  // => FALLING STATE
	}
	
	//--- FOOTSTEP SOUND ATTEMPT ---// 

if (sprite_index == spr_KaDinWalk) and (playerFootstep = 0) and place_meeting(x,y+1,obj_wall)
	{
		audio_play_sound(snd_footstep2,8,false);
		playerFootstep = 24;
		var footstepPitch = random_range(.95,1);
		audio_sound_pitch(snd_footstep2, footstepPitch);
	}
	else if (playerFootstep > 0) { playerFootstep--; }
	
}

function kadinRunState(){									// RUNNING                 -- L/R + RUN BUTTON INPUT 
	
	show_debug_message("Run State");
	//show_debug_message(xSpeed);
	//show_debug_message(ySpeed);
	animSet("RUNNING");
	if(jumpKeyPressed){
		playerState = playerStates.rise;
	}
	
	if(!playerDirection) and (xSpeed = 0){
		playerState = playerStates.idle;
	}
	
	if ( playerDirection >= 1  || playerDirection <= -1 ) and (runType = 0){
		playerState = playerStates.walk;
	}
	
	if (!onGround) and ( ySpeed > 0){														  // IF PLAYER IS FALLING FOR ANY REASON
		playerState = playerStates.fall;													  // => FALLING STATE
	}
	
	//--- FOOTSTEP SOUND ATTEMPT ---// 

if (sprite_index == spr_KaDinRun) and (playerFootstep = 0) and place_meeting(x,y+1,obj_wall)
	{
		audio_play_sound(snd_footstep2,8,false);
		playerFootstep = 18;
		footstepPitch = random_range(.95,1);
		audio_sound_pitch(snd_footstep2, footstepPitch);
	}
	else if (playerFootstep > 0) { playerFootstep--; }
	
}


	

