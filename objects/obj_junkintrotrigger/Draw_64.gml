draw_set_font(global.bigfont)
draw_set_align(fa_center)
draw_set_color(c_white)
if intro_snd != -4
draw_text(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, fmod_event_getTimelinePosition(intro_snd))