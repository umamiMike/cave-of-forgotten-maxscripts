
now = currentTime
global mySpline
global myObj

rollout SplineDefRoll "Untitled" width:162 height:123
(
	pickButton splineButton "Spline Picker" pos:[7,6] width:146 height:24
	pickButton objButton "Object Picker" pos:[7,39] width:146 height:24
	button btn3 "Button" pos:[8,76] width:147 height:29
	on splineButton picked obj do
		mySpline = splineButton.object
	on objButton picked obj do
		myObj = objButton.object
	on btn3 pressed  do
(
			
			
			myPathDef = SpacePathDeform ()
			myPathDef.path = mySpline
			myPathDef.Stretch = 0
			--myObj.height = 500
			--myObj.heightsegs = 500
			myObj.transform = mySpline.transform
			addModifier myObj myPathDef 
			myObj.parent = mySpline
			myObj.isSelected = true
			
			animate on
					
			(
			
			at time now (myPathDef.Percent_along_path = 0)
			at time now (myPathDef.Stretch = 0)
			at time (now + 1) (myPathDef.Stretch = 1)
			at time (now + 29) (myPathDef.Stretch = 1)
			at time (now + 30) (myPathDef.Percent_along_path = 100)
			at time (now + 30) (myPathDef.Stretch = 0)
			
			)
			
				

)
)
closeRolloutFloater myFloater
global myFloater = newRolloutFloater "myFloater" 265 265
addRollout SplineDefRoll myFloater
