// X-PHAGE HUD CODE REWRITE 7/28/24 // 

/// VITALITY + UPGRADE CODE /// 

// Vitality

vitalityGemCount = ( ceil((obj_player.playerVitality-100) / 100));		// Current Number of Stored Vitality Gems
vitalityGemFull = floor( max(0, obj_player.playerVitality) / 100);			// Determines how many Vitality Gems are full 

obj_player.playerVitalityString = string( max(0, obj_player.playerVitality) - (vitalityGemFull * 100) ); // HUD-Displayed Vitality Value 

if (string_length(obj_player.playerVitalityString) == 1) obj_player.playerVitalityString = "0" + obj_player.playerVitalityString; // If there is only one digit, add a '0' before the single-digit.
																																  // Ex: Instead of showing 9, now shows 09. 

// Resolve 

resolveGemCount = ( ceil((obj_player.playerResolve-100) / 100));		// Current Number of Stored Resolve Gems
resolveGemFull = floor( max(0, obj_player.playerResolve) / 100);			// Determines how many Resolve Gems are full 

obj_player.playerResolveString = string( max(0, obj_player.playerResolve) - (resolveGemFull * 100) ); // HUD-Displayed Resolve Value 

if (string_length(obj_player.playerResolveString) == 1) obj_player.playerResolveString = "0" + obj_player.playerResolveString; // If there is only one digit, add a '0' before the single-digit.
																																  // Ex: Instead of showing 9, now shows 09. 
																																  
// Jump Fuel

JumpCanCount = ( ceil((obj_player.playerJumpFuel-100) / 100));		// Current Number of Stored Resolve Gems
JumpCanFull = floor( max(0, obj_player.playerJumpFuel) / 100);			// Determines how many Resolve Gems are full 

obj_player.playerJumpFuelString = string( max(0, obj_player.playerJumpFuel) - (JumpCanFull * 100) ); // HUD-Displayed Resolve Value 

if (string_length(obj_player.playerJumpFuelString) == 1) obj_player.playerJumpFuelString = "0" + obj_player.playerJumpFuelString; // If there is only one digit, add a '0' before the single-digit.
																																  // Ex: Instead of showing 9, now shows 09. 
																																  
																																  
																																  
																																  
									


