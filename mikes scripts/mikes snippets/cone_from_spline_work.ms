now = currentTime


myHeight = $.max[3] - $.min[3]

myPathDef = SpacePathDeform ()
mySpline = $
myPathDef.path = mySpline
myPathDef.Stretch = 1
myObj = cone()
myObj.height = myHeight
myObj.heightsegs = 500
myObj.transform = mySpline.transform
addModifier myObj myPathDef 
myObj.parent = mySpline
myObj.isSelected = true
myPathDef.Percent_along_path = -100

animate on
		
(


--at time now (myPathDef.Stretch = 0)


)