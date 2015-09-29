macroScript object_id
	category:"Mikes"
	toolTip:"object id's for selected objects"
(
	
	
	
rollout id_rollout "id" width:162 height:49
(
	button btn13 "do it" pos:[11,12] width:124 height:23
	on btn13 pressed  do
	for i in 1 to selection.count do 
					(
					selection[i].gbufferchannel = i
					)
)
	
	
	if id_floater != undefined then CloseRolloutFloater id_floater
		id_floater = newRolloutFloater "append array" 265 300
		addRollout id_rollout id_floater

)