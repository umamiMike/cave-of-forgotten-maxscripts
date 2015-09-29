macroScript movekey
	category:"Mikes"
	toolTip:"move keys"
(
	Global framenum_value

	rollout frameroll "move keys" width:162 height:300


	(
		spinner spn1 "yeah" pos:[0,8] width:46 height:16 range:[-100,100,0] type:#integer
		label lbl1 "number of frames" pos:[56,6] width:86 height:16
		button btn1 "move em" pos:[8,32] width:136 height:16
		on spn1 changed val do framenum_value = val
		on btn1 pressed do
			movekeys $ framenum_value
	)

	createdialog frameroll
)
