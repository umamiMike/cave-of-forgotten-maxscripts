if myRoll != undefined do (destroyDialog myRoll)

function convertToBox obArray = (
myBox = box width:1 length:1 height:1
	for i in obArray do (i.baseobject = myBox)
)
function convertCone obArray = (
myBox = cone radius1:0 radius2:1 height:1
	for i in obArray do (i.baseobject = myBox)
)


function selByNameString nameString = (
	
	myPattern = "*"+nameString+"*"
	myObs = for i in objects where matchPattern i.name pattern:myPattern == true collect i
	
	)


	
global my_floater
global myString
global myObjs = #()


rollout myroll "selectByString" width:193 height:34
(
	edittext edt1 "" pos:[4,8] width:139 height:17
	button DoBtn "Select" pos:[150,6] width:34 height:23


	on edt1 entered text do
	(max select none
		myObs = selByNameString edt1.text
		select myObs)
	on DoBtn pressed do
	(max select none
		myObs = selByNameString edt1.text
		select myObs)
)

createDialog myRoll