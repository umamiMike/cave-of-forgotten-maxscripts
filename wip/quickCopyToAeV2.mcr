macroScript copyPosToAe
	category:"Umami"
	toolTip:"Quick Copy the Pos of an Obj to AE"
(
try(



	aeHead = "Adobe After Effects 8.0 Keyframe Data \n \n"
	aeHead += "\tUnits Per Second \t" + framerate as string + "\n"
	aeHead += "\tSource Width \t" + renderwidth as string + "\n"
	aeHead += "\tSource Height \t" + renderHeight as string +  "\n"
	aeHead += "\tSource Pixel Aspect Ratio	1 \n"
	aeHead += "\tComp Pixel Aspect Ratio\t1\n"
	
thePropertyToExport = "Transform	 Position"
theShit =  thePropertyToExport + "\n \t Frame	X pixels\tY pixels\tZ pixels \n"
theShit += "\t" + $.pos[1] as string + "\t"+$.pos[3] as string + "\t"+ $.pos[2] as string
aeEnd =" \n \nEnd of Keyframe Data"

	myShit = aeHead + theShit + aeEnd

	setClipboardtext myShit
)
catch(messagebox "It Failed")
)
