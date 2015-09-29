macroScript SelectedVisSlider
	category:"Mikes"
	toolTip:"adjust a selection's visibility with a slider. duh!"
(


global my_Rollout
global myvisarray
global my_floater
rollout my_Rollout "Untitled" width:295 height:104
(
	slider sld1 "visibility" pos:[6,51] width:276 height:44 range:[0,1,0]
	button btn1 "Button" pos:[6,9] width:276 height:34

	on sld1 changed val do
	(
			for i = 1 to myvisarray.count do
			(
			myvisarray[i].visibility.controller.value = sld1.value
			)
		)
	on btn1 pressed do
	(
			myvisarray = #()
			
			for i = 1 to selection.count do
			(
			append myvisarray selection[i]
			)
			for i = 1 to myvisarray.count do
			(
			myvisArray[i].visibility = bezier_float()
			
			)
		)
)
if my_floater != undefined then closeRolloutFloater my_floater
	my_floater = newRolloutFloater "name me" 465 265
			addRollout my_rollout my_floater


)