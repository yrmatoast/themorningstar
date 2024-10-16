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

function scr_solid(_x = 0, _y = 1)
{
	return place_meeting(x + _x, y + _y, obj_solid)
}