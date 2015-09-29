macroScript simpleFileNaming Icon:#("umamiIcons",6)

	category:"Umami"
	toolTip:"Simple Render File Naming"
(


global umFileRoll
global  umFileFloater
addText = ""
sep = "_"

fn doIt = (

renderSceneDialog.close()
FileName = getfilenamefile rendOutputFilename
FilePath = getfilenamepath rendOutputFilename
FileXtn = getfilenametype rendOutputFilename
mycam = getActiveCamera()
myNewName = mycam.name
rendOutputFilename = FilePath + myNewName + sep + addText + FileXtn
renderSceneDialog.open()

)

rollout umFileRoll "Simple File Naming" width:280 height:88
(
	button btn1 "doBtn" pos:[180,8] width:80 height:24
	edittext edt1 "" pos:[8,8] width:160 height:24



	on btn1 pressed do
		doIt()
	on edt1 entered text do
		addText = text
)




if umFileFloater != undefined then closeRolloutFloater umFileFloater
umFileFloater = newRolloutFloater "umami Simple File Setting" 280 72
			addRollout umFileRoll umFileFloater
		


)	 
