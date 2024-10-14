if (!ds_list_empty(errors))
{
	for (var i = 0; i < ds_list_size(errors); i++)
	{
		var q = ds_list_find_value(errors, i)
		with q
		{
			timer = approach(timer, 0, 1)
			if timer <= 0
			{
				with other
				{
					q = undefined
					ds_list_delete(errors, i)
					i--
				}
			}
		}
	}
}
