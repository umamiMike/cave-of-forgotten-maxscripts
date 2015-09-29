myArray = selection as array
for i = 1 to myArray.count do

(
now = currentTime


myPathDef = SpacePathDeform ()
mySpline = myArray[i]
myPos = getKnotPoint mySpline 1 1
myPathDef.path = mySpline
myPathDef.Stretch = 0
myObj = box()
myObj.height = 500
myObj.heightsegs = 250
myObj.transform = mySpline.transform
addModifier myObj myPathDef 
myObj.parent = mySpline
myObj.isSelected = true

myObj.pivot = mypos
animate on
		
(

at time now (myPathDef.Percent_along_path = 0)
at time now (myPathDef.Stretch = 0)
at time (now + 29) (myPathDef.Percent_along_path = 0)
at time (now + 29) (myPathDef.Stretch = 1)
at time (now + 80) (myPathDef.Percent_along_path = 100)
at time (now + 60) (myPathDef.Stretch = 1)
at time (now + 80) (myPathDef.Stretch = 0)

)
)