// STATIC HUD CODE REWRITE FOR X-PHAGE '24 // 
depth = -9998
// HUD GRAPHIC OVERLAY // 

hudSprite = spr_FakeHUD;			// HUD Overlay
hudPosX   = 0;						// HUD X Position
hudPosY   = 0;						// HUD Y Position

// MESSAGE TICKER // 

tickerText = "";					// Ticker Message-Text ("" for blank)
tickerDisplayTime = 5;				// Ticker Display-Time (in seconds)
tickerAlarm = 0;					// Ticker Alarm (for setting object alarm)
tickerPosX = 0;						// Ticker X-Position
tickerPosY = 0;						// Ticker Y-Position

// VITALITY BAR // 

vitalityBarSprite = spr_VitalityBar;  // Vitality Bar Sprite 
vitalityWidth = 60;					// Vitality Bar Width
vitalityHeight = 13;					// Vitality Bar Height
vitalityPosX = 135;					// Vitality Bar X-Position
vitalityPosY = 354;					// Vitality Bar Y-Position

vitalityLowSprite = spr_VitalityLow;  // Vitality Bar Low Sprite
vitalityLowPosX = 90;				// Vitality Bar Low X-Position
vitalityLowPosY = 354;				// Vitality Bar Low Y-Position

vitalityIconSprite = spr_HUDVitality; // Vitality Icon Sprite 
vitalityIconPosX = 101;				// Vitality Icon X-Position
vitalityIconPosY = 354;				// Vitality Icon Y-Position

// VITALITY GEMS // 

vitalityGemWidth = 0;				// Vitality Gem Width
vitalityGemHeight = 0;				// Vitality Gem Height 
vitalityGemPosX = 0;				// Vitality Gem X-Position
vitalityGemPosY = 0;				// Vitality Gem Y-Position

// RESOLVE BAR // 

resolveBarSprite = spr_ResolveBar;   // Resolve Bar Sprite 
resolveWidth = 60;					// Resolve Bar Width
resolveHeight = 13;					// Resolve Bar Height
resolvePosX = 135;					// Resolve Bar X-Position
resolvePosY = 378;					// Resolve Bar Y-Position

resolveLowSprite = spr_ResolveLow;	 // Resolve Bar Low Sprite 
resolveLowPosX = 0;					// Resolve Bar Low X-Position
resolveLowPosY = 0;					// Resolve Bar Low Y-Position

resolveIconSprite = spr_HUDResolve   // Resolve Icon Sprite
resolveIconPosX = 101;				// Resolve Icon X-Position
resolveIconPosY = 378;				// Resolve Icon Y-Position

// RESOLVE GEMS // 

resolveGemWidth = 0;				// Resolve Gem Width
resolveGemHeight = 0;				// Resolve Gem Height 
resolveGemPosX = 0;					// Resolve Gem X-Position
resolveGemPosY = 0;					// Resolve Gem Y-Position

// GEMS COUNTER // 

gemsIconSprite = spr_GemsIcon;		 // GEMS Icon Sprite 
gemsIconWidth = 8;					// GEMS Icon Width
gemsIconHeight = 22;				// GEMS Icon Height
gemsIconPosX = 423;					// GEMS Icon X-Position
gemsIconPosY = 374;					// GEMS Icon Y-Position

gemsBalancePosX = 437;				// GEMS Balance X-Position
gemsBalancePosY = 378;				// GEMS Balance Y-Position

// JUMP FUEL // 

JumpFuelWidth = 0;					// Jump Fuel Width  
JumpFuelHeight = 0;					// Jump Fuel Height 
JumpFuelPosX = 0;					// Jump Fuel X-Position
JumpFuelPosY = 0;					// Jump Fuel Y-Position

JumpFuelLowWidth = 0;				// Jump Fuel Low-Indicator Width
JumpFuelLowHeight = 0;				// Jump Fuel Low-Indicator Height
JumpFuelLowPosX = 0;				// Jump Fuel Low-Indicator X-Position
JumpFuelLowPosY = 0;				// Jump Fuel Low-Indicator Y-Position

JumpFuelUpgradePosX = 0;			// Jump Fuel Upgrade X-Position
JumpFuelUpgradePosY = 0;			// Jump Fuel Upgrade Y-Position

// VIDEO DISPLAY UNITS (VDUs) // 

vduLeftBoxSprite = spr_LeftVDU;
vduLeftImageStaticSprite = spr_RedStatic;
vduLeftImageSprite = spr_KadinTboxNeutral; 
vduLeftImagePosX = 0;
vduLeftImagePosY = 326; 


vduRightBoxSprite = spr_RightVDU;
vduRightImageStaticSprite = spr_BlueStatic;
vduRightImageSprite = spr_TboxNone;
vduRightImagePosX = 576;
vduRightImagePosY = 326; 







