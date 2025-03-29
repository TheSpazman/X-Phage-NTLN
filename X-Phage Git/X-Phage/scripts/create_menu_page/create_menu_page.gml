function create_menu_page(){
	
///@description create_menu_page
///@arg ["Name1", type1, entries1...]
///@arg ["Name2", type2, entries2...]
	
show_debug_message("New Menu Page Created");
	
var arg;

var i=0;

	repeat(argument_count)							// Loop repeats for as many arguments as provided.
	
	{
		
		arg[i] = argument [i]; 
		i++;
		
	}
	
var ds_grid_id = ds_grid_create(5, argument_count); // Creates grid + ID (5 cells wide) , stores as variable.

i = 0;												// Denotes current placement on grid. 0 = Entry One, 1 = Entry Two, Etc.. 
	
	repeat(argument_count)							// Looping through entries of the menu array
	
	{
		
		var array = arg[i];
		var array_len = array_length(array)			// Loop through arguments to assemble each menu option.
		
		var xx = 0; repeat(array_len)				// xx is the current menu-option cell in the X-axis being worked-on. Loop as necessary.
		
			{
				ds_grid_id[# xx, i] = array[xx];	// xx = x, i = y. Setting up cells on a grid! 
				xx++								// Every time loop finishes, increment xx by 1 
			}
			
		i++;										// Proceed to the next menu entry. 
		
	}





return ds_grid_id; // Returns Grid ID to be stored as menu-page variable.
}