-- add choice of whether the user wants seperate controllers for each object or one controller for all objects

global myController
global ControllerParentRoll
global ControllerParentFloater

rollout ControllerParentRoll "Make a Picked Object the Parent of Selected Objects" width:276 height:84
(
	pickbutton btn2 "Pick The Controller Object" pos:[8,12] width:240 height:24
	button btn3 "Add to Selected Objects" pos:[8,48] width:240 height:24
--pick an object to act as the controller

--do button


	on btn2 picked obj do(
		myController = btn2.object 
		btn2.caption = btn2.object.name
		
		)
	on btn3 pressed  do(
	if selection.count != 0 do(
		for i = 1 to selection.count do(
		
		myUseController = copy myController
		myObj = selection[i]
		if myObj.parent != undefined do (myOriginalParent = myObj.parent)
		myUseController.position = myObj.position
		myObj.parent = myUseController
		myUseController.parent = myOriginalParent
		myUseController.name = myObj.name + "Controller"
	
			)
	
	)
	)
	
	
)

if ControllerParentFloater != undefined then closeRolloutFloater ControllerParentFloater
ControllerParentFloater = newRolloutFloater "CopyControllerAsParent" 276 108
			addRollout ControllerParentRoll ControllerParentFloater
			 
