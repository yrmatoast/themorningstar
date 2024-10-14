function scr_collision()
{
	var _ground =  place_meeting(x, y + 1, par_solid) && vsp >= 0
	var _checkby = .5 // HALF a pixel, this just works!
	var _slopecheckthing = 24
	if place_meeting(x + hsp, y, par_solid)// Horizontal Shit
	{
		if !place_meeting(x + hsp, y - _slopecheckthing, par_solid) // check for pixel, if no, go up
		{
			while place_meeting(x + hsp, y, par_solid) 
			{
				y -= _checkby
			}
		}
		else
		{
			var _checkby2 = _checkby * sign(hsp)
			while !place_meeting(x + _checkby2, y, par_solid)  //basic collision
				x += _checkby2
			hsp = 0
			if place_meeting(x, y, obj_slope)
				y--
		}
	}
	
	
	if vsp >= 0 && !place_meeting(x + hsp, y + 1, par_solid) && place_meeting(x + hsp, y + _slopecheckthing, par_solid) // go DOWN slopw
	{
		while !place_meeting(x + hsp, y + _checkby, par_solid) 
		{
				y += _checkby
		}
	}
	
	var _checkby2 = _checkby * sign(vsp)
	if place_meeting(x, y + vsp, par_solid) // Vertical Shit
	{
		while !place_meeting(x, y + _checkby2, par_solid)  //basic collision
			y += _checkby2
			vsp = 0
	}
	
	if place_meeting(x, y + vsp, obj_platform)
	{
		if bbox_bottom - 1 < instance_place(x, y + vsp, obj_platform).y && vsp >= 0
		{
			while !place_meeting(x, y + _checkby2, obj_platform)
				y += _checkby2
			vsp = 0
			_ground = true
		}
	}
	
	
	/*
	//y collisioons shit
	var _clampvsp = max(0, vsp)
	var _list = ds_list_create()
	var _array = array_create(0)
	array_push(_array, obj_solid, obj_platform)
	//check
	var list_size = instance_place_list(x, y + 1 + _clampvsp + 8, _array, _list, false)
	
	//loop
	for (var i = 0; i < list_size; i++)
	{
		//get obj instance
		var _listInst = _list[| i]
		
		//return objects
		if instance_exists(platformid)
		&& place_meeting(x, y + 1 + _clampvsp, _listInst)
		{
			if _listInst.object_index == obj_solid
			|| object_is_ancestor(_listInst.object_index, obj_solid)
			|| floor(bbox_bottom) <= ceil(_listInst.bbox_top)
			{
				if !instance_exists(platformid)
				|| _listInst.bbox_top <= platformid.bbox_top
				|| _listInst.bbox_top <= bbox_bottom
				{
					platformid = _listInst
				}
				
			}
		}
	}
	ds_list_destroy(_list)
	//ooone more check... im a chud loser XDDD
	if instance_exists(platformid) && !place_meeting(x, y + 1, platformid)
		platformid = noone

	if instance_exists(platformid)
	{
		while !place_meeting(x, y + _checkby2, platformid) && !place_meeting(x, y, obj_solid)
			y += _checkby2
		if platformid.object_index == obj_platform
		|| object_is_ancestor(platformid.object_index, obj_platform)
			while place_meeting(x, y, platformid)
				y -= _checkby
		vsp = 0
		_ground = true
	}*/
	
	
	grounded = _ground //set for grounded...
	if grounded
		y = floor(y);
	y += vsp
	x += hsp
}

function scr_sloped(_x = 0, _y = 1)
{
	return place_meeting(x + _x, y + _y, obj_slope)
}

function scr_slope_get(_x = 0, _y = 1)
{
	return instance_place(x + _x, y + _y, obj_slope)
}