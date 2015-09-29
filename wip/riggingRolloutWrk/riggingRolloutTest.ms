
rollout grin "Grin Control"
(
slider happy "Happy" orient:#vertical across:5 range:[-100,100,0]
slider sad "Sad" orient:#vertical
slider oo "OO" orient:#vertical
slider ee "EE" orient:#vertical
slider oh "OH" orient:#vertical


on sad changed val do (try($.radius = val) catch())
on happy buttondown do (flagForeground $ true)
	on happy changed val do($.position.controller.x_position += val)
	on happy buttonup do (flagForeground $ false)

)
theNewFloater = newRolloutFloater "Grinning" 300 220
addRollout grin theNewFloater

