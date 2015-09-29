global myLength = 1.0
global myWidth = .5


rollout my_roll "Untitled" width:162 height:300
(
	button Dobtn "Do it" pos:[5,71] width:95 height:21
	spinner spn2 "length" pos:[14,6] width:104 height:16
	spinner spn3 "width" pos:[13,43] width:104 height:16 range:[0,100,0]
	on Dobtn pressed do
	(
	now = currentTime
	myPathDef = SpacePathDeform ()
	mySpline = $
	myPathDef.path = mySpline
	myPathDef.Stretch = 1
	myObj = box()
	myObj.length = myLength
	myObj.width = myWidth
	myObj.height = 1
	myObj.heightsegs = 100
	myObj.transform = mySpline.transform
	addModifier myObj myPathDef 
	myObj.parent = mySpline
	myObj.isSelected = true
	myPathDef.Percent_along_path = -100
	
	animate on
			
	(
	
	
	--at time now (myPathDef.Stretch = 0)
	
	
	)
		
		)
	on spn2 changed val do
		myLength = spn2.value
	on spn3 changed val do
		myWidth = spn3.value
)
		global my_floater = newRolloutFloater "Box Grow" 265 265
		addRollout my_roll  my_floater
