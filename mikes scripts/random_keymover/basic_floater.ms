rollout Anim_Map_Floater "Untitled" width:219 height:215
(
	listBox lbx1 "ListBox" pos:[12,12] width:195 height:2
	on lbx1 doubleClicked sel do
(
	
	)
)

if rt_floater != undefined then CloseRolloutFloater rt_floater
rt_floater = newRolloutFloater "Mikes Pretty Script" 195 400
addRollout Anim_Map_Floater rt_floater