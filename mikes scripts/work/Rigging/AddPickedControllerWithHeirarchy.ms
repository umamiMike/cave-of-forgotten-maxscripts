
global myRoll
global  my_floater

global myBaseObj



rollout myRoll "rolloutname" width:200 height:150
(
	pickbutton BaseObjPickBtn "Pick the Controller Object" pos:[8,8] width:147 height:21
	button DoBtn "Controllers to Selected Obj's" pos:[8,39] width:148 height:28 enabled:true


	on BaseObjPickBtn picked obj do
	(
			myBaseObj = BaseObjPickBtn.object
			BaseObjPickBtn.caption = myBaseObj.name as string
	)
	on DoBtn pressed  do
(
		for i = 1 to selection.count do (
	
		use = copy myBaseObj
		myObj = selection[i]
		use.position = myObj.position
		--myChildren = my
		myParent = myObj.parent
		use.parent = myParent
		myObj.parent = use
		
	)
)

)

if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "myFlotaerName" 200 150
			addRollout myRoll my_floater
			 
