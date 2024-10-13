for (var i = 0; i < 4; i++)
{
	draw_sprite(spr_hud_health, i, 64 + 16 + (64 * i), 64 +sin((current_time / 115) - (i * 128 * 4)) * 5)
}
draw_sprite_part(spr_hud_speedometer_meter, noiseindex, 0, 0, 4 + cam_tar.movespeed / 16 * (229), 64, 32 + 16, 64 * 2 + 16)
draw_sprite(spr_hud_speedometer_front, 0, 32, 64 * 2)
draw_sprite(noisesprite, noiseindex, 64 + cam_tar.movespeed / 20 * (64 * 4 - 16), 64 * 2 + 20)
draw_sprite(cuphud, 0, 32 * 12, 64 + 16 + cupoffset)