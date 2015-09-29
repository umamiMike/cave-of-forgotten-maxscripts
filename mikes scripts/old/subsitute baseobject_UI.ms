
global myRoll
global fromObj
global toObj
global my_floater

rollout myroll "rolloutname" width:225 height:101
(
	pickButton frmBtn "The From Object" pos:[8,6] width:94 height:30
	label lbl1 "Is copied to:" pos:[14,45] width:85 height:16
	pickButton toBtn "The To Object" pos:[10,64] width:94 height:30
	button doBtn "Do It" pos:[120,10] width:86 height:84





	on frmBtn picked obj do
		(
		fromObj = obj
		frmBtn.caption = fromObj.name
		)
	on toBtn picked obj do
		(
			toObj = obj
			toBtn.caption = toObj.name
		)

	on doBtn pressed do
		(
		undo on
		(
		toObj.baseobject = fromObj.baseobject
		toObj.material = fromObj.material
		)
		)

)


if my_floater != undefined then closeRolloutFloater  my_Floater
my_floater = newRolloutFloater "myFlotaerName" 300 150
addRollout myRoll my_floater
			
