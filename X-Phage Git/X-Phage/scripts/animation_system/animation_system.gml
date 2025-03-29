// X-PHAGE UNIVERSAL ANIMATION SCRIPT COMPILATION. //

// THIS PAGE CONTAINS DIFFERENT FUNCTIONS PERTAINING TO THE USE  OF X-PHAGE'S UNIVERSAL ANIMATION SYSTEM, AND WHERE TO USE THEM. 
// == PAY CLOSE ATTENTION TO THE COMMENTS IF YOU DO NOT UNDERSTAND SOMETHING! I TRY TO COMMENT LIBERALLY. == 

#region ANIMATION TYPE AND KEY ENUMERATOR

enum animationType {				// ENUMERATOR FOR TYPES OF INFORMATION
	
	looped,							// LOOPED ANIMATIONS
	chained,						// CHAINED ANIMATIONS
	finite							// FINITE ANIMATIONS 

}

enum animationKey {					// KEY TO DETERMINE ANIM-TYPE VARIABLE TO MODIFY 

	animType		= 0,			// WHAT TYPE OF ANIMATION IS IT? LOOPED / CHAINED / FINITE?
	animTagName		= 1,			// WHAT IS THE NAME OF THE ANIMATION-TAG? ( I.E.: RUN / WALK / JUMP / ETC. ) 
	scaleX			= 2,			// X-SCALE
	scaleY			= 3,			// Y-SCALE
	maxAnimSpeed	= 4,			// MAX SPEED OF ANIMATION 
	startFrame		= 5,			// STARTING FRAME -- STARTS AT 0 
	endFrame		= 6,			// ENDING FRAME   -- STARTS AT 0
	spriteIndex		= 7,			// SPRITE NAME TO CHANGE SELECTED OBJECT TO. 
	repeatAmount	= 8,			// REPEAT THIS ANIMATION 'X' AMOUNT OF TIMES. OMITTED IF LOOPED ANIMATION. 
	nextAnimTag		= 9				// WHAT ANIMATION TAG TO CHAIN TO NEXT, IF CHAINED ANIMATION. 
	
}

#endregion

#region CREATE-EVENT ANIMATION INITIALIZATION SCRIPT

// CALL THIS IN CREATE-EVENT // 

function animInit(){
	_animationMap = ds_map_create(); // STORE ANIM ARRAYS HERE 
	_currentAnimTag = "none";		 // CURRENT ANIM
	_animIterations = 0;			 // HOW MANY TIMES TO LOOP ANIM 
	image_speed = 0;				 // INIT IMAGE-SPEED 0 SO NO ANIM PLAYS ON START-UP.
}

#endregion

#region DESTROY-EVENT SCRIPT TO PREVENT MEMORY LEAK

// CALL THIS IN DESTROY-EVENT TO PREVENT MEMORY LEAKAGE // 

function animDestroy(){

	if(ds_exists(_animationMap, ds_type_map))
		{
			ds_map_destroy(_animationMap);
		}

}

#endregion

#region ADD LOOPED ANIMATION

// THIS FUNCTION ADDS LOOPED ANIMATIONS // 

function animAddAnim(_animTagName, _scaleX, _scaleY, _maxAnimSpeed, _startFrame, _endFrame, _spriteIndex)
{

	_animationMap[? _animTagName] = [animationType.looped, _animTagName, _scaleX, _scaleY, _maxAnimSpeed, _startFrame, _endFrame, _spriteIndex, noone, noone];

}

#endregion

#region ADD CHAINED ANIMATION

// THIS FUNCTION ADDS CHAINED ANIMATIONS // 

function animAddChainedAnim(_animTagName, _scaleX, _scaleY, _maxAnimSpeed, _startFrame, _endFrame, _spriteIndex, _repeatAmount, _nextAnimTag)
{

	_animationMap[? _animTagName] = [animationType.chained, _animTagName, _scaleX, _scaleY, _maxAnimSpeed, _startFrame, _endFrame, _spriteIndex, _repeatAmount, _nextAnimTag];

}

#endregion

#region ADD FINITE ANIMATION

// THIS FUNCTION ADDS FINITE ANIMATIONS // 

function animAddFiniteAnim(_animTagName, _scaleX, _scaleY, _maxAnimSpeed, _startFrame, _endFrame, _repeatAmount)
{

	_animationMap[? _animTagName] = [animationType.finite, _animTagName, _scaleX, _scaleY, _maxAnimSpeed, _startFrame, _endFrame, _repeatAmount, noone];

}

#endregion

#region SET CURRENT ANIMATION (W/ TAG NAME) 

// SETS THE CURRENT ANIM TAG USING TAG-NAME // 

function animSet(animationTag)
{

	if(_currentAnimTag != animationTag)
		{
			_currentAnimTag = animationTag;
			image_index = 0;
			sprite_index = _animationMap[? _currentAnimTag][animationKey.spriteIndex];
			_animIterations = 0;
		}

}

#endregion

#region GET CURRENT ANIMATION (W/ TAG NAME) 

// -GETS- THE CURRENT ANIMATION USING TAG-NAME // 

function animGet()
{
	return _currentAnimTag;
}
#endregion

#region STEP-EVENT ANIMATION SCRIPT

function animStep()
{
	animStepExtended(_animationMap[? _currentAnimTag][animationKey.maxAnimSpeed]);
}
// CALL THE ANIM STEP-EVENT // 
function animStepExtended(animationSpeed) 
{
	// IF THE ANIM-TAG DOES NOT EXIST, THEN THIS DOES NOTHING. //
	if(ds_map_exists(_animationMap, _currentAnimTag))
		{
			var checkScaleX = _animationMap[? _currentAnimTag][animationKey.scaleX];
			var checkScaleY = _animationMap[? _currentAnimTag][animationKey.scaleY];
			
			if(checkScaleX != noone) image_xscale = checkScaleX;
			if(checkScaleY != noone) image_yscale = checkScaleY;
			
				if(is_undefined(animationSpeed))
					{	// Only support anim-speeds between 0 and 1. //
						image_speed = max(min(_animationMap[? _currentAnimTag][animationKey.maxAnimSpeed], 1), 0); 
						
					}else{
						// Only support anim-speeds between 0 and 1. //
						image_speed = max(min(min(animationSpeed, _animationMap[? _currentAnimTag][animationKey.maxAnimSpeed]), 1), 0);
						
					}
					
			// PULL PARAMETERES FOR CURRENT ANIM TAG // 
			var startFrame		= _animationMap[? _currentAnimTag][animationKey.startFrame];
			var endFrame		= _animationMap[? _currentAnimTag][animationKey.endFrame];
			var repeatAmount	= _animationMap[? _currentAnimTag][animationKey.repeatAmount];
			var nextAnimTag		= _animationMap[? _currentAnimTag][animationKey.nextAnimTag];
			
			// IF-CHECKS FOR CONTROLLING ANIM FRAMES // 
			if(floor(image_index) < startFrame) // If we haven't started the anim.. 
			{
				image_index = startFrame; // ..Set the frame to the starting position. 
			}
			else if(floor(image_index) > endFrame) // If we're beyond, or have reached the end of the anim.. 
			{
				image_index = startFrame; // ..loop back to the start. 
			}
			else if(floor(image_index) == endFrame) // If we have finished the anim.. 
			{
				_animIterations++; // INCREASE ANIM ITERATION COUNT FOR FINITE / CHAINED ANIMS 
				
				switch(_animationMap[? _currentAnimTag][animationKey.animType])
				{
					case animationType.looped:
					
						image_index = startFrame; // RESET TO ANIM START
						break;
						
					case animationType.finite:
					
						if(_animIterations >= repeatAmount)
							{
								image_index = 0;
							}
						break;	
						
					case animationType.chained: // PLAYS AN ANIMATION X AMOUNT OF TIMES BEFORE ZEROING ANIM, MOVING TO NEXT IN CHAIN. 
					
						if(_animIterations >= repeatAmount)
							{
								image_speed = 0;
								animSet(nextAnimTag);
							}
						break;
					
				}
			}
		}
}

#endregion