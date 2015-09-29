
global my_floater
global myString
global myObjs = #()


rollout myroll "rolloutname" width:253 height:47
(
	edittext edt1 "" pos:[4,8] width:139 height:17
	button DoBtn "Select" pos:[150,6] width:93 height:23
	on edt1 entered text do
		myString = text as string
	on DoBtn pressed do
	(
	for i = 1 to objects.count do(
	
	myName = objects[i].name
	
	myPattern = "*"+myString+"*"
	if matchPattern myName pattern:myPattern == true then (append  myObjs objects[i])
	
	
	)
	select myObjs
		
		)
)



if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "SelByString" 300 70
			addRollout myRoll my_floater
			
