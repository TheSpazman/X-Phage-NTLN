
#region RUN THIS WHEN THE MAIN-MENU SCREEN IS EXITED.

var i = 0, array_len = array_length(menu_pages);

	repeat (array_len)
	{
		ds_grid_destroy(menu_pages[i]);
		i++;
	}

font_delete(global.font_main);

#endregion
