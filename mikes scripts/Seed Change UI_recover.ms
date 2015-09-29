
global myRoll
global  my_floater

rollout myRoll "Seed Change" width:197 height:58
(


	button btn3 "Seed Change Multi" pos:[10,11] width:168 height:32
		
		
	on btn3 pressed do
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
)


if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "Seed Change Floater" 300 150
			addRollout myRoll my_floater
			 
