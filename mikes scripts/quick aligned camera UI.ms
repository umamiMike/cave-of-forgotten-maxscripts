
global looklycamRoll
global  lookycam_floater

rollout looklycamRoll "rolloutname" width:225 height:101
(
	button Do_btn "Do it" pos:[14,9] width:178 height:41


	on Do_btn pressed  do
(

myOldobj = $
	
	macros.run "Lights and Cameras" "Camera_CreateFromView"
	
	
	$.parent = $.target
	$.target.parent = myOldObj
	)
)
if lookycam_floater != undefined then closeRolloutFloater lookycam_floater
lookycam_floater = newRolloutFloater "myFlotaerName" 300 150
			addRollout looklycamRoll lookycam_floater
			 