
global myRoll
global my_floater
global myPrefix

rollout myRoll "change names and append class" width:225 height:101
(
	edittext edt1 "" pos:[120,12] width:97 height:24
	label lbl1 "The Prefix" pos:[54,17] width:57 height:24




	button btn1 "Rename Selected" pos:[16,51] width:147 height:30



	on edt1 entered text do
		myPrefix = edt1.text
	on btn1 pressed  do
		(
		for i = 1 to selection.count do (

			myobj = selection[i]
			myclass = classof myobj as string
			myName = myPrefix + myclass
			myobj.name = myName
			


)
	
	
		)
)





if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "Change names Floater" 300 150
			addRollout myRoll my_floater
			 
