function makeCalloutForSel = (
	theCam = getActiveCamera()
	for i in selection do (makeCallout i theCam)
	
)

function makeCallout theObject theCam = (
	
myText  = text name:("callohhut_" + theObject.name) text:(theObject.name) position:theObject.center
myText.parent = theObject
--myText.lookat = theCam
		
)