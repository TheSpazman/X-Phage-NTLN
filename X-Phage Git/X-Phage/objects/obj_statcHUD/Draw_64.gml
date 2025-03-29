/// Starting the Static HUD Script, and reorganizing / annotating. /// 


// ..If the Player Exists, then... //

////////////////////////////////////////

//-- LEFT VDU CODE --// 


// All of this is to be considered placeholder. // 

draw_sprite_ext(vduLeftImageSprite, image_index, vduLeftImagePosX, vduLeftImagePosY,1,1,image_angle,c_white,1);				// VDU Image
draw_sprite_ext(vduLeftImageStaticSprite, image_index, vduLeftImagePosX, vduLeftImagePosY,1,1,image_angle,c_white,0.25);	// VDU Static
//draw_sprite(vduLeftBoxSprite, -1, vduLeftImagePosX, vduLeftImagePosY);														// VDU Box 

////////////////////////////////////////

//-- RIGHT VDU CODE --// 


// All of this is to be considered placeholder. // 

draw_sprite_ext(vduRightImageSprite, image_index, vduRightImagePosX, vduRightImagePosY,1,1,image_angle,c_white,1);				// VDU Image
draw_sprite_ext(vduRightImageStaticSprite, image_index, vduRightImagePosX, vduRightImagePosY,1,1,image_angle,c_white,0.25);		// VDU Static
//draw_sprite(vduRightBoxSprite, -1, vduRightImagePosX, vduRightImagePosY);														// VDU Box

///////////////////////////////////////

//-- HUD OVERLAY (640X400)  --//

if(instance_exists(obj_player))  
	{
	  draw_sprite(spr_FakeHUD, -1,0,0); // Make the HUD fill the screen dimensions, at a multiple of 640x400.                   
	}

image_speed = 0.20;
/////////////////////////////////////

draw_set_halign(fa_left);
draw_set_font(global.font_numb);

//-- VITALITY BAR --// 

draw_sprite(vitalityIconSprite, -1, vitalityIconPosX, vitalityIconPosY);
draw_sprite_stretched(vitalityBarSprite, -1, vitalityPosX, vitalityPosY, 
	(obj_player.playerVitality/obj_player.playerVitalityMax) * vitalityWidth, vitalityHeight);

//-- VITALITY BAR GEMS CODE --// 

var _w = sprite_get_width(spr_VitalityGem);
var _h = sprite_get_height(spr_VitalityGem);
var _columnsPerRow = 4; 
var _fullVitalityGems = vitalityGemCount; 


var _i = 0; 
repeat (vitalityGemCount)
	{
		var _row =  floor( _i / _columnsPerRow);
		var _column =  (_i - (floor(_i / _columnsPerRow) * _columnsPerRow) );      // 2 Rows of 4 columns of gems = 8 possible Vitality Upgrades (Slots in HUD)
		var _gemFull = (_fullVitalityGems > 0);
		
		draw_sprite(spr_VitalityGem,_gemFull, vitalityGemPosX + (_column * _w), vitalityGemPosY + _h - (_row * _h));
		
		_fullVitalityGems--;
		_i++; 
	}
	
	draw_text_transformed_colour(vitalityPosX - 12, vitalityPosY, obj_player.playerVitalityString, 1, 1, image_angle, $8c3afc, $8c3afc, $8c3afc, $8c3afc, 1);
					// Displays the Player's vitality stat at these specific places, determined via variables 

//-- VITALITY 'LOW' INDICATOR --// 

if (obj_player.playerVitality/obj_player.playerVitalityMax) < 0.25
	{
		draw_sprite(vitalityLowSprite, -1, vitalityLowPosX, vitalityLowPosY); 
	}

/////////////////////////////////////

//-- RESOLVE BAR --// 

draw_sprite(resolveIconSprite, -1, resolveIconPosX, resolveIconPosY);
draw_sprite_stretched(resolveBarSprite, -1, resolvePosX, resolvePosY, (obj_player.playerResolve/obj_player.playerResolveMax) * resolveWidth, resolveHeight);

//-- RESOLVE BAR GEMS CODE --// 

var _w = sprite_get_width(spr_ResolveGem);
var _h = sprite_get_height(spr_ResolveGem);
var _columnsPerRow = 4; 
var _fullResolveGems = resolveGemCount; 


var _i = 0; 
repeat (resolveGemCount)
	{
		var _row =  floor( _i / _columnsPerRow);
		var _column =  (_i - (floor(_i / _columnsPerRow) * _columnsPerRow) );      
		var _gemFull = (_fullResolveGems > 0);
		
		draw_sprite(spr_ResolveGem,_gemFull, resolveGemPosX + (_column * _w), resolveGemPosY + _h - (_row * _h)); // 2 Rows of 4 columns of gems = 8 possible Resolve Upgrades (Slots in HUD)
		
		_fullResolveGems--;
		_i++; 
	}
	
	draw_text_transformed_colour(resolvePosX - 12, resolvePosY, obj_player.playerResolveString, 1, 1, image_angle, c_aqua, c_aqua, c_aqua, c_aqua, 1);
					// Displays the Player's resolve stat at these specific places, determined via variables 

//-- RESOLVE 'LOW' INDICATOR --// 

if (obj_player.playerResolve/obj_player.playerResolveMax) < 0.25
	{
		draw_sprite(resolveLowSprite, -1, resolveLowPosX, resolveLowPosY); 
	}

///////////////////////////////////////

//-- JUMP FUEL CODE --// 

var _Jw = sprite_get_width(spr_JumpFuelUpgrade);
var _Jh = sprite_get_height(spr_JumpFuelUpgrade);
var _JcolumnsPerRow = 4; 
var _fullJumpCans = JumpCanFull; 


var _i = 0; 
repeat (JumpCanCount)
	{
		var _Jrow =  floor( _i / _JcolumnsPerRow);
		var _Jcolumn =  (_i - (floor(_i / _JcolumnsPerRow) * _JcolumnsPerRow) ); 
		var _JumpCanFull = (_fullJumpCans > 0);
		
		draw_sprite(spr_JumpFuelUpgrade,_JumpCanFull, JumpFuelUpgradePosX + (_Jcolumn * _Jw), JumpFuelUpgradePosY + _Jh - (_Jrow * _Jh));
		
		_fullJumpCans--;
		_i++; 
	}
	


//-- GEMS COUNTER CODE --//

draw_sprite_stretched(gemsIconSprite, 0,gemsIconPosX,gemsIconPosY,gemsIconWidth,gemsIconHeight);
draw_text_transformed_colour(gemsBalancePosX, gemsBalancePosY, obj_player.gemsBalance, 1, 1, image_angle, $8c3afc, $8c3afc, $8c3afc, $8c3afc, 1);

//-- MESSAGE TICKER CODE --// 

if (tickerText != "" && alarm[tickerAlarm] >= 0) 
	{
		draw_set_font(global.font_main);
		draw_set_halign(fa_left);
		show_debug_message("This Should be Running!" + string(alarm[tickerAlarm]))
		draw_text_transformed_color(tickerPosX, tickerPosY, tickerText,1,1,0,$8c3afc,$8c3afc,$8c3afc,$8c3afc,1);
	}

///////////////////////////////////////