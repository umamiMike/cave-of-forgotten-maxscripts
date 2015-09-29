now = currentTime


myPathDef = SpacePathDeform ()
mySpline = $
myPathDef.path = mySpline
myPathDef.Stretch = 0
myObj = cone()
myObj.height = 500
myObj.heightsegs = 500
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