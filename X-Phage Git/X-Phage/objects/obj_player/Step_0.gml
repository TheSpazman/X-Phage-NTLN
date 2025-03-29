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

	case playerStates.idle:
		kadinIdleState();
		break;
		
	case playerStates.rise: 
		kadinRisingState(); 
		break;
	case playerStates.jump:
		kadinJumpState();
		break;
		
	case playerStates.fall:
		kadinFallState();
		break;
		
	case playerStates.land:
		kadinLandState();
		break;
		
	case playerStates.walk:
		kadinWalkState();
		break;
		
	case playerStates.run:
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


