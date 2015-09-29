
	--myFile = createFile "test.txt"
	--copys the shit to the clipboard
	--myeuler = quatToEuler $.rotation
tab = "\t"
lBreak = "\n"
fromRange = 0
toRange = 100

	aeHeadInfo = "Adobe After Effects 8.0 Keyframe Data" + lBreak + "
	" + "Units Per Second" + "	" + framerate as string +"
	Source Width" + "	" + renderwidth as string + "
	Source Height" + "	" + renderHeight as string + "
"+ tab + "Source Pixel Aspect Ratio	1
	Comp Pixel Aspect Ratio	1" + lBreak


fn thePosProp = (

	thePropHead1 = "Transform" + tab + "Position"
	thePropHead2 = lBreak + tab + "Frame	X pixels	Y pixels	Z pixels" +  lBreak
	thePosArray = #()
	for i = fromRange  to toRange do(
			myTime = trimRight (currentTime as string) "f" 
	nowProp = at time (i) thePropPerFrame = tab + i +tab+ $.pos[1] as string + tab + "-"+$.pos[3] as string + tab + $.pos[2] as string
	)
	
    theInfo = thePropHead1 + thePropHead2 + thePropPerFrame
)
-- 		

aeEnd = lBreak + "End of Keyframe Data"

	
	myShit = aeHeadInfo + thePosProp() + aeEnd

	setClipboardtext myShit
