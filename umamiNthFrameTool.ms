try(destroyDialog NthFrameToolRoll)catch()

function printFramesBy fr t b = (
x = ""
for i = fr to t by b do (
	
	x += i as string
	x += ", "
	 
	)
	
y = trimRight x ", "
y
	)
	
	
	
	
rollout NthFrameToolRoll "Umami nTh Frame Tool" width:302 height:58
(
	button btn1 "X" pos:[248,12] width:24 height:24 tooltip:"will copy frame range string to clipboard, just paste it in to the custom range window"
	spinner fromSpn "From" pos:[18,16] width:61 height:16 range:[0,99999,0] type:#integer scale:1
	spinner toSpn "To" pos:[91,16] width:61 height:16 range:[0,99999,100] type:#integer scale:1
	spinner bySpn "By" pos:[168,16] width:61 height:16 range:[0,99999,10] type:#integer scale:1

	on btn1 pressed do (
		
		theseFrames = printFramesBy fromSpn.value toSpn.value bySpn.value
		print theseFrames
		setClipBoardText theseFrames
		)
	
	)

createDialog NthFrameToolRoll
