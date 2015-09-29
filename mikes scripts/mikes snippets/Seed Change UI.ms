
global myRoll
global  my_floater

rollout myRoll "rolloutname" width:225 height:101
(
	button btn1 "Seed Change 1" pos:[10,7] width:170 height:34


	button btn3 "Seed Change Multi" pos:[13,52] width:168 height:32
		
		
	on btn1 pressed do
	(
	
	$.position.controller[2].controller.seed = random 1 5000
	$.rotation.controller[2].controller.seed = random 1 5000
	
	
	
	
	)
	on btn3 pressed  do
	(
	myarray = selection as array
	
	
	for i = 1 to myarray.count do
	(
	select myarray[i]
	
	$.position.controller[2].controller.seed = random 1 5000
	$.rotation.controller[2].controller.seed = random 1 5000
	
	)
	select myarray
	
	)
)if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "myFlotaerName" 300 150
			addRollout myRoll my_floater
			 
