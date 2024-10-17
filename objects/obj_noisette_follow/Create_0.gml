lag = 60
followqueue = ds_queue_create()
targetfollower = obj_player
gx = x
gy = y
ds_list_add(global.followerlist, id)
pos = ds_list_find_index(global.followerlist, id) + 1
spr_idle = spr_noisette_idle_junk
spr_walk = spr_noisette_follow_junk
sprite_index = spr_idle
ogx = x
ogy = y
depth = 1
image_speed = 0.35
spot = false