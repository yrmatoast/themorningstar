if active
{
	with obj_player1
	{
		x = approach(x, other.x, 10)
		y = approach(y, other.y, 10)
		state = -4
		vsp = 0
		hsp = 0
		set_sprite("fall")
		if key_jump2
		{
			instance_create_depth(x, y + 5, 5, obj_basicparticle, {
				sprite_index: spr_jumpcloud
			})
			vsp = -14
			event_play_oneshot3d("event:/Sfx/jump", x, y)
			set_sprite("jump", 0)
			state = states.jump
			jumpstop = false
			other.active = false
			other.usabletimer = 60
		}
	}
}
if usabletimer > 0
	image_alpha = 0.5
else
	image_alpha = 1
usabletimer = approach(usabletimer, 0, 1)