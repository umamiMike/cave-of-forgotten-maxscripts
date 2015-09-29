--align and parent


global myRoll
global  my_floater
myFromObj
myToObj

rollout myRoll "Quick Align and Parent" width:200 height:150
(
	pickbutton btn1 "Align and parent Me" pos:[16,16] width:112 height:23
	pickbutton btn2 "To Me" pos:[16,56] width:112 height:23
	
	
	button btn5 "Do It" pos:[20,101] width:106 height:23
		
	on btn1 picked obj do
	(
			myFromObj = copy obj
			btn1.caption = myFromObj.name as string
			)
	on btn2 picked obj do
	(
		myToObj = obj
			btn2.caption = obj.name as string
			
			)
	on btn5 pressed  do
(
		if (myFromObj != undefined) and (myToObj != undefined) then (
		
		myFromObj.pos = myToObj.pos
		myFromObj.parent = myToObj
		
		
		
		)
	)
)


if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "AlignAndParent" 200 150
			addRollout myRoll my_floater
			 
