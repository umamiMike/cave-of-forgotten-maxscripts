
global RendcamRoll
global  RendcamFloater

global addString = ""

rollout RendcamRoll "Render Filename from Active Camera" width:200 height:104
(
	button btn1 "Do it!" pos:[8,64] width:176 height:24
	edittext edt1 "" pos:[0,32] width:184 height:16
	label lbl1 "Extended Attributes" pos:[48,8] width:104 height:16


	on btn1 pressed do
	(
			renderSceneDialog.close()
			FileName = getfilenamefile rendOutputFilename
			FilePath = getfilenamepath rendOutputFilename
			FileXtn = getfilenametype rendOutputFilename
			mycam = getActiveCamera()
			if mycam != undefined then (
			myNewName = mycam.name
			myInfo = FilePath + myNewName+addString+"_"+FileXtn
			if querybox myInfo  beep:true then (
			rendOutputFilename = myInfo
			renderSceneDialog.open()
			
			)
			else ()
			)
			else (messagebox "The active viewport must be a camera" title:"Error Yo")
		)
	on edt1 entered text do
		(addString = text
		edt1.text = "")
)


if RendcamFloater != undefined then closeRolloutFloater RendcamFloater
RendcamFloater = newRolloutFloater "Render Filename from Active Camera" 200 125
			addRollout RendcamRoll RendcamFloater
			 
