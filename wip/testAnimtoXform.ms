xformName = "xform"
destroyDialog xformNameRoll


rollout xformNameRoll "Untitled" width:304 height:42
(
	edittext edt1 "" pos:[98,11] width:155 height:16
	label lbl1 "name of xform" pos:[8,10] width:83 height:19
	button btn2 "Do it" pos:[266,14] width:26 height:17

	on btn2 pressed  do
(
	disableSceneRedraw()
	suspendEditing()
	xformName = edt1.text
	myXform = xform()
	addmodifier $ myXform
	myXform.name = xformName

myXform.gizmo.controller = copy $.transform.controller
deleteKeys $.transform.controller #allKeys
		destroyDialog xformNameRoll
	xfromNameRoll = undefined
	resumeEditing()
	enableSceneRedraw()
	)
)

createDialog xformNameRoll

