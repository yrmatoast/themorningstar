saveicon.timer = approach(saveicon.timer, 0, 1)
saveicon.alpha = approach(saveicon.alpha, abs(sign(saveicon.timer)), 0.1)
saveicon.index += 0.35