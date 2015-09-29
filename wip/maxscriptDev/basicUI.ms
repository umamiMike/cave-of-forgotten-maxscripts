

-- Global Vars here
global myRoll
global my_floater

--Functions Here
		
rollout myRoll "rolloutname" width:224 height:101
(
	button DoBtn "Do me" pos:[8,64] width:160 height:24

	

	
	on DoBtn pressed  do(
		
	

	)

)






if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "myFlotaerName" 224 150
			addRollout myRoll my_floater
			 
