// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function new_game(){
show_debug_message("New Game Selected");
global.pause = 0;
page = menu_page.main;
room_goto(rm_game);
}