---script flow-pick an object, the object must 

global Splinearray = #()


global obj_to_splinesRoll
global  obj_to_splinesFloater

rollout obj_to_splinesRoll "Copy To Splines" width:225 height:101
(
	button DoBtn "Do it" pos:[11,74] width:157 height:20

	button SplineArray_btn "Splines to copy to" pos:[11,10] width:156 height:24


	on DoBtn pressed do
			(
			
			for i = 1 to selection.count do
			( for i in 1 to splineArray.count do
				(
				myobj = copymgroup
				
				)
			
		
				
				)
			)
	on SplineArray_btn pressed  do
		(
			SplineArray = #()
			for i = 1 to selection.count do
			(
				 if classof selection[i] == SplineShape then (append SplineArray selection[i])
				else (messagebox "Your objects must ALL be Splines")
			
			)
			)
)


if obj_to_splinesFloater != undefined then closeRolloutFloater obj_to_splinesFloater
obj_to_splinesFloater = newRolloutFloater "myFlotaerName" 300 150
addRollout obj_to_splinesRoll obj_to_splinesFloater
			 