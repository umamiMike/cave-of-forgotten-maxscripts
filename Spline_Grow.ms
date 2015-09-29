myArray = selection as array

global myLength
blobal myob

fn SplineMake = (

ss = splineshape()

addNewSpline ss

for i = 1 to mylength as integer by 4 do

(
addKnot ss 1 #smooth #curve [0,0,i]

)

updateshape ss

myobj = ss

)


for i = 1 to myArray.count do

(
mySpline = myArray[i]
now = currentTime
myLength = curvelength mySpline 1

myPathDef = SpacePathDeform ()

myPos = getKnotPoint mySpline 1 1
myPathDef.path = mySpline
myPathDef.Stretch = 0
myObj = SplineMake()
--myObj.height = -100
--myObj.width = 5
--myObj.length = 2
--myObj.heightsegs = 100
myObj.transform = mySpline.transform
addModifier myObj myPathDef 
myObj.parent = mySpline
myObj.isSelected = true

myObj.pivot = mypos
animate on
		
(

at time now (myPathDef.Percent_along_path = 0)
at time now (myPathDef.Stretch = 1)
--at time (now + 29) (myPathDef.Percent_along_path = 50)
at time (now + 29) (myPathDef.Stretch = 1)
--at time (now + 80) (myPathDef.Percent_along_path = 100)
--at time (now + 60) (myPathDef.Stretch = 1)
--at time (now + 80) (myPathDef.Stretch = 0)

)
)