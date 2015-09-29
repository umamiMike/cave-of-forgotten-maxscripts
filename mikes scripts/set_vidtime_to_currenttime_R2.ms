-- this will make the starttime of a video file which is a map = to the currenttime,
-- and add the value of the end time to the end so it plays, 
--also should make it hold
global myroll
global my_floater

rollout myroll "Set the diffuse map video of sel object" width:200 height:101
(
	button SetVidBtn "Set Selected Vid Times to Current" pos:[8,56] width:165 height:26
	button repdiffbtn "replace diff of selected items" pos:[8,13] width:165 height:26
	

	on SetVidBtn pressed do
	(
	undo on
		(
				for i = 1 to selection.count do
				(
				if selection[i].mat != undefined then(
				mymap = selection[i].mat.diffusemap
				mymap.startTime = currenttime
				mymap.endCondition = 2
				)
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
				
					if myobj.mat != undefined and myobj.mat.diffusemap != undefined then 
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
if my_floater != undefined then closerolloutfloater my_floater
my_floater = newRolloutFloater "Set Video Times to Current" 200 120
			addRollout myRoll my_floater
