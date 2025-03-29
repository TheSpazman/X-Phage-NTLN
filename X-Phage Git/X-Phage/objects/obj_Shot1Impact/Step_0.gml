//if !audio_is_playing(snd_shot1collide)
	//{							 
	//	audio_play_sound(snd_shot1collide, 1, false,0.5);					
	//	audio_sound_pitch(snd_shot1collide, random_range(0.9,1.0));	
//	}
	
	if snd_count < snd_delay											// If the current sound-count is lower than the delay-timer, then
		{
			snd_count++;												// Increment the sound-count by 1. 
		}else{															// otherwise..
			snd_count = 0;												// zero-out the sound-count timer
			audio_play_sound(snd_shot1collide, 1, false);                 // and play the textbox sound for this particular box, 
			audio_sound_pitch(snd_shot1collide, random_range(0.9,1.0));   // and randomize the pitch of the audio slightly.
		}