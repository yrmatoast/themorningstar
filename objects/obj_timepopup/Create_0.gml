var _msec = wrap(global.timer, 0, 59)
var _mseconds = _msec
if _msec < 10
	_mseconds = string("0{0}", _msec)
var _sec = wrap(global.timer / 60, 0, 59)
var _seconds = _sec
if _sec < 10
	_seconds = string("0{0}", _sec)
var _minutes = wrap(global.timer / (60 * 60), 0, 59)
time = string("{2}:{1}:{0}", _mseconds, _seconds, _minutes)