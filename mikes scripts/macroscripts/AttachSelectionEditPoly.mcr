macroScript AttachSelectionEditPoly
	category:"Mikes"
	toolTip:"attach all selected objects together as 1 editable poly"
(

global myobjects
rollout Attach_roll "Attach em" width:162 height:300
(
	button btn1 "Do it!" pos:[6,6] width:148 height:28


	on btn1 pressed  do
(
myobjects = selection as array

convertTo myobjects[1] PolyMeshObject
	
	for i = 2 to myobjects.count do
	(
	convertTo myobjects[i] PolyMeshObject
		myobjects[1].attach myobjects[i] myobjects[1]
	)
)
)
	Attach_floater = newRolloutFloater "name me" 265 265
			addRollout Attach_roll Attach_floater

)