-- this will make the starttime of a video file which is a map = to the currenttime,
-- and add the value of the end time to the end so it plays, 
--also should make it hold
		global myRoll
		try (destroyDialog myRoll) catch()

rollout myroll "setVidtimeToCurrent Time" width:161 height:101
(
	button btn8 "set times of current selection" pos:[8,56] width:151 height:28
	button repdiffbtn "replace diff of selected items" pos:[8,13] width:151 height:28
	

	on btn8 pressed do
	(
	undo on
		(
				for i = 1 to selection.count do
				(
				mymap = selection[i].mat.diffusemap
				mymap.startTime = currenttime
				mymap.endCondition = 2
				)
		)
	)
	on repdiffbtn pressed do
	(
	undo on
		(
	for i = 1 to selection.count do 
				(
					myobj = selection[i]
				
					if myobj.mat.diffusemap != undefined then 
						(
						myobj.mat.diffusemap.viewImage()
						mymap = myobj.mat.diffusemap 
						mynewmap = getOpenFileName()
						myobj.mat.diffusemap.filename = mynewmap
						mymap.startTime = currenttime
						mymap.endCondition = 2
						)
						
				)
	
		)

	)
)



		createDialog myRoll

--my_floater = newRolloutFloater "myFlotaerName" 190 150
		--	addRollout myRoll my_floater
