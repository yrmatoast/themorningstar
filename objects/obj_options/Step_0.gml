__ti_input()
var m = menus[menu]
var opt = m.options
var _length = array_length(opt) - 1
var q = opt[selected]
var move = q.type != optmenu.slider ? (key_left2 + key_right2) : (key_left + key_right)
var move2 = -key_up2 + key_down2
if move != 0 && q.type != optmenu.press
{
	q.val += move
	q.val = clamp(q.val, 0, q.max)
	q.func()
}
if move2 != 0
{
	selected += move2
	selected = wrap(selected, 0, _length)
}
if key_jump2
{
	if q.type == optmenu.toggle
	{
		q.val += 1
		q.val = wrap(q.val, 0, q.max)
	}
	q.func()
}
if key_slap2
{
	m.backfunc()
}