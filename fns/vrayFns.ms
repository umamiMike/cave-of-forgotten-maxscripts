--internal fns
fn getAllVrayMatsInScene = (
	
	myVrayMats = getClassInstances VRayMtl
	
	)



fn setThisVrayToAllChannels vrayMat = (
	vrayMat.reflection_affectAlpha = 2
	vrayMat.refraction_affectAlpha = 2
	)
	



--programs to run	
fn SetVrayMatsToAllChannels = (
myVrayMats = getAllVrayMatsInScene()	
	
for i in myVrayMats do (setVrayToAllChannels i)
	
	
)
	
