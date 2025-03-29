
// All of the game's dialogue will likely be stored here! 

/// @param text_id

function game_text(_text_id){

switch(_text_id)
	{
		// DEBUG SPEAKERBLOCKS
		case "speakblock 1":
		change_text("If you're reading this, the game_text function is working correctly!");
		break; 
		
		case "speakblock 2":
		change_text("This box now tests boxes with options! Choose a selection above to test functionality!");
			scr_option(" Option A","sb2opA");
			scr_option(" Option B","sb2opB");
			scr_option(" Option C","sb2opC");
		break; 
			
			case "sb2opA":
			change_text("The first option (A) works completely! If it doesn't, something is broken!");
			break;
			
			case "sb2opB":
			change_text("Option B Selected! If this doesn't come up, something is broken!");
			break;
			
			case "sb2opC":
			change_text("Option C Selected! If this doesn't come up, consider adding debug code!");
			break;
			
		case "speakblock 3":
		change_text("This textbox has been updated from its previous version! *Important things* will now be shown in Yellow!");
		scr_text_color(57,75,c_yellow,c_yellow,c_yellow,c_yellow); scr_text_color(97,104,c_yellow,c_yellow,c_yellow,c_yellow);
		break; 
		
		case "speakblock 4":
		change_text("This is a single blue block, designed to test some new game-functionality pertaining to the dialogue-system. If this works, congrats! If it doesn't, you wouldn't be seeing this!","kadinneutral");
		change_text("In the future, this could be modified to work as 'invisible' triggers for point-and-click style interaction with the mouse-cursor... Also; pauses and ellipses work now!",,"leonneutral");
		change_text("As of now, this dialogue-system also includes support for animated portraits alongside the written dialogue!","kadinneutral");
		break;
		
		// EXIT GAME
		case "quitgame":
		change_text("WARNING: Are you sure? This will quit to desktop, and any possible unsaved progress will be lost!");
		scr_text_color(0,8,c_red,c_red,c_red,c_red);
			scr_option(" YES ","quityes");
			scr_option(" NO ","quitno");
				
				case "quityes":
				//game_end();
				break;
			
				case "quitno":
				break;
				
		// TEST-ROOM 2 TEXTBOX 
		case "testroom2":
		change_text("If the code works, then this textbox should be playing when the player stands over this object and hits the global 'confirm' key.","kadinneutral");
		break;
		
	}

}