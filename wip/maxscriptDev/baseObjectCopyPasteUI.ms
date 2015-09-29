

-- Global Vars here
global myRoll
global my_floater
global myBase
global myMat

--Functions Here
		
rollout myRoll "rolloutname" width:224 height:101
(
	button DoBtn "paste baseobj" pos:[119,32] width:100 height:24

	

	

	button btn2 "pick baseObj" pos:[15,36] width:100 height:24
	
	on DoBtn pressed do
	(
			$.baseobject = myBase
			$.material = myMat
	
		)
	on btn2 pressed do
	(
			myBase = selection[1].baseobject
			myMat = selection[1].material
		
	
		)
)






if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "myFlotaerName" 224 150
			addRollout myRoll my_floater
			 
