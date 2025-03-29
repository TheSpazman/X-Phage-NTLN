/// @description Setup Camera


camera		= camera_create();

var vm		= matrix_build_lookat(x,y,-10,x,y,0,0,1,0);
var pm		= matrix_build_projection_ortho(640,400,1,10000);

camera_set_view_mat(camera , vm)


cam			= view_camera[0];										//Getting the name of the camera / viewport number.
follow		= obj_player;												// Camera follows the oldest instance of this object. Only one player-instance should exist.
view_w_half = camera_get_view_width(cam) * 0.5;						// Getting camera width and height.
view_h_half = camera_get_view_height(cam) * 0.5;
xTo			= xstart;												// Where the camera is moving to, on the x and y plane. Are interchangeable with 'x' and 'y'.
yTo			= ystart;
playerSnap	= false;

// Parallax Scrolling BGs, two slots. (Unused for now)

//Parallax1 = layer_get_id("Parallax1");
////Parallax1ID = layer_tilemap_get_id(Parallax1);
//Parallax2 = layer_get_id("Parallax2");
////Parallax2ID = layer_tilemap_get_id(Parallax2);
//Parallax3 = layer_get_id("Parallax3");
////Parallax3ID = layer_tilemap_get_id(Parallax3);
//
//Parallax1Move = 0;
//Parallax2Move = 0;
//Parallax3Move = 0;










