// REORGANIZED 3/29/25 -- SPAZ

#region PLAYER INPUT

get_controls();

#endregion

#region PLAYER PHYSICS

//-- SET UP PLAYER PHYSICS --// 

if playerCanMove { player_physics_normal(); };

#endregion

#region PLAYER BASIC MOVEMENT STATES
//--- ANIMATION CONTROL -- I will likely be revising this -- Too unintuitive. ---// 

switch (playerState) {

	case playerStates.idle:  //IDLE
		kadinIdleState();
		break;
		
	case playerStates.rise:  //JUMP START
		kadinRisingState(); 
		break;
		
	case playerStates.jump:  //MID-AIR
		kadinJumpState();
		break;
		
	case playerStates.fall:  //FALLING
		kadinFallState();
		break;
		
	case playerStates.land:  //LANDING
		kadinLandState();
		break;
		
	case playerStates.walk:  //WALKING
		kadinWalkState();
		break;
		
	case playerStates.run:   //RUNNING
		kadinRunState();
		break;

}

//show_debug_message(playerState)
animStep();

#endregion

#region PLAYER ATTACK STATES 

// -- ATTACK CODE -- // 

player_attack();

#endregion


