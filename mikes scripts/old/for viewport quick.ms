
global myMap



rollout Vieport_map_rollout "Untitled" width:162 height:300

(

	mapButton btn5 "MapButton" pos:[9,7] width:140 height:26

	button btn10 "do it" pos:[12,43] width:135 height:24
	

	on btn5 picked texmap do


		(

		myMap = texmap

		)

	on btn10 pressed  do

(
	setAsBackground myMap

	)

)
createdialog Vieport_map_rollout