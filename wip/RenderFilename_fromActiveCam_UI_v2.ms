if rendCamRoll != undefined then destroyDialog rendCamRoll
global RendcamRoll


global addString = ""
global handle = 0
global addString = ""
global inFrame = 0
global outFrame = 0
function selObjFrames = 
(
	try(
inFrame = $.mat.diffusemap.starttime - handle
myBmInfo = getBitmapInfo $.mat.diffusemap.bitmap
outFrame = $.mat.diffusemap.starttime + myBmInfo[11] + handle
--messageBox(inFrame as string + "   " + outFrame as string)
		
)
catch()
)

myPath = maxFilePath + "renderScenes\\" -- make a variable or something to extend functionality
if getDirectories myPath == 0 then ()
else (makeDir myPath)

rollout RendcamRoll "Render Filename from Active Camera" width:200 height:200
(
	button btn1 "Do it!" pos:[12,109] width:176 height:24
	edittext edt1 "" pos:[7,85] width:184 height:16
	label lbl1 "Extended Attributes" pos:[45,64] width:104 height:16
	spinner spn1 "Handle" pos:[18,15] width:86 height:16 range:[0,1000,0] type:#integer
	

	on btn1 pressed do
	(
		try(
		
			renderSceneDialog.close()
			selObjFrames()
			-- this section was designed to set for video start and stop times not needed atm BUT im keeping it in so i remember the bit of code
-- 			if $ != undefined then
-- 			(
-- 			rendTimeType = 3
-- 			rendStart = inFrame
-- 			rendEnd = outFrame
-- 			)
-- 			else(rendTimeType = 2)
-- 			
			FileName = getfilenamefile rendOutputFilename
			FilePath = getfilenamepath rendOutputFilename
			FileXtn = getfilenametype rendOutputFilename
			mycam = getActiveCamera()
			if mycam != undefined then (
			myNewName = --mycam.name
			myInfo = FilePath +addString+"_"+FileXtn
			if querybox myInfo  beep:true then (
			rendOutputFilename = myInfo
			renderSceneDialog.open()
			
				mySaveInfo = myPath + addString+".max"
			savemaxfile mySaveInfo
			)
			else ()
			)
			else (messagebox "The active viewport must be a camera" title:"Error Yo")
		)
		catch()
		)
	on edt1 entered text do
	(addString = text
	edt1.text =text)
	on spn1 changed val do
		handle = val
)


createDialog rendCamRoll
			 
