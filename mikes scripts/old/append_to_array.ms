myarray= #()
rollout my_Rollout "append array" width:162 height:34
(
	button btn1 "add me" pos:[5,9] width:62 height:21
		

	button btn12 "remove me" pos:[83,10] width:69 height:20

	on btn1 pressed do
		if $!= undefined then append myarray $
	
	on btn12 pressed  do
		deleteItem myarray myarray.count
)


if my_floater != undefined then CloseRolloutFloater my_floater
	my_floater = newRolloutFloater "append array" 265 300
	addRollout my_rollout my_floater
