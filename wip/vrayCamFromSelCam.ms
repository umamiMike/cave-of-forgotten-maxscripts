function newVrayCam = (

newVrayCam = VRayPhysicalCamera whiteBalance_preset:7 whiteBalance:(color 255 235.802 191.397)  pos:[-7103.1,4716.81,-6.36537]
newVrayCam.targeted = false
newVrayCam.targeted = true
return newVrayCam	
)

function xFormXfer theVrayCam orCam = (
	
	theVrayCam.position.controller = copy orCam.position.controller
	
	if (classof selection[1] == Targetcamera)   then (

		theVrayCam.target.transform.controller = copy orCam.target.transform.controller
		)
	
	theVrayCam.name = selection[1].name + "VCam"
	theVrayCam.specify_fov = on
	theVrayCam.fov = selection[1].fov		
	
	
	)
function mainLoop = (
	
	if (classof selection[1] == Targetcamera)   then (
		orCam = selection[1]
		thisCam = newVrayCam()
		xFormXfer thisCam orCam

		)
	)
	
	
mainLoop()