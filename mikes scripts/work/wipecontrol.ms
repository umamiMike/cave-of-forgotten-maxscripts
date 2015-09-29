global myMap
global myMapPercent




rollout wipeRoll "Wiper" width:382 height:141
(
	slider sld1 "Slider" pos:[6,5] width:363 height:44 enabled:true range:[0.5,1.5,0.5] type:#float ticks:20
	mapButton btn1 "pick the map" pos:[14,63] width:69 height:26
			on sld1 changed val do
			(
			
				myMap.coords.V_Offset = sld1.value
				
				)
	on sld1 buttondown  do
			(
				
				)
	on sld1 buttonup  do
			(
				
				)
	on btn1 picked texmap do
				(
					myMap = btn1.map
			)
)

--if wipe_floater != undefined then closeRolloutFloater wipe_floater
wipe_floater = newRolloutFloater "Wipecontrol" 365 150
			addRollout wipeRoll wipe_floater
