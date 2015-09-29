macroScript Append_to_array
	category:"Mikes"
	toolTip:"append to array"
(
	
	
	
global myarray= #()
	rollout my_Rollout "append array" width:162 height:34
	(
		button btn1 "add me" pos:[5,9] width:62 height:21
			

		button btn12 "remove me" pos:[83,10] width:69 height:20

		on btn1 pressed do
		(
			
			for i = 1 to selection.count do
			(
			append myarray selection[i]
			
			)
			
			for i = 1 to myarray.count do
			(
			myarray[i].name = "Placard" + i as string
			)
		)
		
		on btn12 pressed  do
			if myarray != undefined then deleteItem myarray myarray.count
	)


	if my_floater != undefined then CloseRolloutFloater my_floater
		my_floater = newRolloutFloater "append array" 265 300
		addRollout my_rollout my_floater
)
