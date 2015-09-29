macroScript MapProp Icon:#("umamiIcons",6)
	category:"Mikes"
	toolTip:"Propogate Map to Selected Materials"
(

global Propfloater
global myMap

rollout PropRollout "propagate map to selection" width:162 height:92
(
	mapButton btn3 "MapButton" pos:[26,4] width:106 height:25
	button btn6 "Propagate to Selection" pos:[19,38] width:123 height:22
	
	
	
	on btn3 picked texmap do
		(myMap = btn3.map)
	on btn6 pressed do
	(
			if selection.count != undefined then (
			
				for i = 1 to selection.count do
				(
				mymat = selection[i].mat
				mymat.diffusemap = mymap
				mymat.selfIllumAmount = 100
				
				)
				)
				)
)


if Propfloater != undefined then closeRolloutFloater Propfloater
Propfloater = newRolloutFloater "Copy Map to selection mats" 265 110
addRollout PropRollout Propfloater
	
	
)