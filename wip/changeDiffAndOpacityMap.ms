-- this will make the starttime of a video file which is a map = to the currenttime,
-- and add the value of the end time to the end so it plays, 
--also should make it hold
		global myRoll
		try (destroyDialog myRoll) catch()

rollout myroll "replaceDiffnOpacityMap" width:200 height:101
(
	button repdiffbtn "replace diff/opacity of sel items" pos:[8,13] width:180 height:28 toolTip: "Replace the bitmap of the opacity slot and the diffuse slot"

	on repdiffbtn pressed do
	(
	undo on
		(
	for i = 1 to selection.count do 
				(
					m = selectBitmap caption:"Open plate image..."
					diff = bitmapTexture bitmap:m
					myobj = selection[i]
				
					if myobj.mat.diffusemap != undefined then 
						(
						--myobj.mat.diffusemap.viewImage()
						mymap = myobj.mat.diffusemap 
						mynewmap = m
						diff.monoOutput = 1
						myobj.mat.diffusemap = diff
						myobj.mat.opacitymap = diff
						myobj.mat.diffusemap.startTime = currenttime
						mymap.endCondition = 2
						)
						
				)
	
		)

	)
)



		createDialog myRoll

--my_floater = newRolloutFloater "myFlotaerName" 190 150
		--	addRollout myRoll my_floater
