macroScript AddSprings
	category:"Mikes"
	toolTip:"Add Springs"
(


rollout my_Rollout "Untitled" width:162 height:48
(
	button btn3 "add spring to selection" pos:[9,5] width:136 height:29


	on btn3 pressed  do
		(
				for i = 1 to selection.count do (
				selection[i].pos.controller = SpringPositionController ()
				
				
				)
			)
)

	my_floater = newRolloutFloater "Add Springs" 265 265
			addRollout my_rollout my_floater
)
