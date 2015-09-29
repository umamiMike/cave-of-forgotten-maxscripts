
global myRoll
global  my_floater
global myarray = #()
global myobj
global myspeed = 5
global mytime


fn fadeIn = 

(
undo on (
myobj.visibility = bezier_float()
			
			animate on
			
					(
					at time 0f (myobj.visibility.controller.value = 0)
					at time (mytime) (myobj.visibility.controller.value = 0)
					at time (mytime + myspeed) (myobj.visibility.controller.value = 1)
					)
					deleteKey myobj.visibility.controller.keys 1
			)
	)




rollout myroll "rolloutname" width:225 height:365
(
	edittext edt1 "time" pos:[55,4] width:118 height:16


	button btn1 "Do IT!" pos:[22,38] width:154 height:25
		
	on edt1 entered text do
	(
			append myarray text
			edt1.text = ""
			)
	on btn1 pressed  do(
	
	for i = 1 to selection.count do
	(
	mytime = myarray[i] as integer
		myobj = selection[i]
		fadeIn()
	
	
	)
	
	
	)
)




if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "myFlotaerName" 300 400
			addRollout myRoll my_floater
			 
