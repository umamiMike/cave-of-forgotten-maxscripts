--myFile = createFile "test.txt"
--copys the shit to the clipboard
myeuler = quatToEuler $.rotation

--myCurrentProperty = Transform	Position
thePropertyToExport = "Transform	 Position"

--function printDataFormat myProperty

aeInfo = "Adobe After Effects 8.0 Keyframe Data

	"+"Units Per Second" + "	" + framerate as string +"
	Source Width" + "	" + renderwidth as string + "
	Source Height" + "	" + renderHeight as string + "
	Source Pixel Aspect Ratio	1
	Comp Pixel Aspect Ratio	1
" + thePropertyToExport + "
	Frame	X pixels	Y pixels	Z pixels
	"
	
	theShit = "	" + $.pos[1] as string + "	"+ "-"+$.pos[3] as string + "	"+ $.pos[2] as string
aeEnd ="	

End of Keyframe Data"

myShit = aeInfo + theShit + aeEnd

setClipboardtext myShit