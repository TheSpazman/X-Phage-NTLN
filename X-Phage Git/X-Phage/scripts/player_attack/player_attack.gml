// BAREBONES PLAYER ATTACK SCRIPT / FUNCTION


function player_attack(){

	if (playerFireDelay > 0) // If attack cooldown isn't 0, reduce to 0. 
		{
		  playerFireDelay = max(0,playerFireDelay-1);
		}
	else
		{
			if (fireKey) && (!instance_exists(obj_Weapon))
				{
					playerFireDelay = playerFireMaxDelay; // CooldownTimer
					instance_create_layer(x,y-16,"Instances",obj_Weapon);
				}
			else if (fireKey) && (instance_exists(obj_Weapon))
				{
					playerFireDelay = playerFireMaxDelay
				}
		}
}