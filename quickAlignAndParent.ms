--align and parent


global myRoll
global  my_floater
myFromObj
--myToObj = undefined
myToArray = #()

rollout myRoll "Quick Align and Parent" width:200 height:150
(
	pickbutton btn1 "Align and parent Me" pos:[16,16] width:112 height:23
	button btn2 "To Me" pos:[16,56] width:112 height:23
	button btn5 "Do It" pos:[20,101] width:106 height:23
		
	on btn1 picked obj do
	(
			myFromObj = obj
			btn1.caption = myFromObj.name as string
			)
	on btn2 pressed do
	(
	  myToArray = selection as array
			btn2.caption = myToArray.count as string + " Objects Selected"
			
			)
	on btn5 pressed  do
( undo on (
		--if (myFromObj != undefined) and (myToArray.count > 0) then (
		
		
		for i = 1 to myToArray.count do (
		
		myOb = myFromObj
		myOb.position = myToArray[i].position
		myOb.rotation = myToArray[i].rotation
		--myFromObj.parent = myToObj
		)
		
		
		
		--)
	))
)


if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "AlignAndParent" 200 150
			addRollout myRoll my_floater
			 
