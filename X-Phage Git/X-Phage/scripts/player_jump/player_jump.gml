// PART OF THE X-PHAGE CODE MODERNIZATION PROJECT -- 4/6/25 -- SPAZ
// HOPING TO WORK THIS OUT TO GET JUMP-FUEL MECHANICS BACK INTO THE GAME. DIVIDE INTO REGIONS WHEN POSSIBLE!


function player_jump(){      // PLAYER JUMP + FUEL CONTROLS 



	if ((jumpKey || jumpKeyPressed ) && jumpFuelAmount > 0)						// IF JUMP KEY PRESSED / HELD -AND- JUMP-FUEL IS GREATER THAN 0
		{
			 
			if (JumpFuelDelay < 0.15)														//	IF JUMP-DELAY IS LESS THAN 0.15 (TICKS?) 
				{																				//
					JumpFuelDelay += deltaTime;														// INCREASE JUMP-DELAY BY DELTATIME;
					show_debug_message(string(JumpFuelDelay) + "microseconds");						// SHOW JUMP-FUEL DELAY IN MICROSECONDS.
				}
				
			else																			//  IF JUMP-DELAY IS GREATER THAN 0.15 (TICKS?)
			
				{
					jumpFuelAmount -= jumpFuelLossRate;										// SUBTRACT PLAYER-FUEL BY THE DEFINED LOSS-RATE.
				}
				
			ySpeed = jumpSpeed[0];														// VERTICAL SPEED = VERTICAL JUMP-SPEED;
			onGround = 0																// PLAYER IS NO LONGER ON THE GROUND.
			
		}
	else																			// IF THE JUMP-KEY IS RELEASED / NOT-PRESSED, OR JUMP FUEL IS 0, 
		{																			
			ySpeed += grav;																// VERTICAL-SPEED SHOULD BE INCREASED (DOWNWARD) BY THE GRAVITY VALUE.
		}


	if (ySpeed < 0) && (!jumpKeyPressed) ySpeed = max(ySpeed,0) // IF VERTICAL-SPEED IS LESS THAN 0 AND JUMP-KEY IS NOT HELD, VERTICAL SPEED = MAX OF VERTSPEED, AND 0. 
}

function player_fuel_regen(){														// JUMP-FUEL REGEN SCRIPT
	
jumpFuelAmount = min(jumpFuelMax, jumpFuelAmount + jumpFuelRegenRate);     // PLAYER JUMP-FUEL = THE MINIMUM OF (THE MAX AMT OF FUEL, (PLR JUMP-FUEL + JUMP-FUEL REGEN-RATE)

}