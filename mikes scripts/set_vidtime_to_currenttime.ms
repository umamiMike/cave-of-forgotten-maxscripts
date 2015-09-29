-- this will make the starttime of a video file which is a map = to the currenttime,
-- and add the value of the end time to the end so it plays, 
--also should make it hold

rollout myroll "rolloutname" width:225 height:101
(
	button btn8 "set times of current selection" pos:[10,56] width:151 height:28
	button btn10 "replace diff of selected items" pos:[10,13] width:180 height:26
	

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
	on btn10 pressed do
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

my_floater = newRolloutFloater "myFlotaerName" 300 150
			addRollout myRoll my_floater
