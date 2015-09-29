macroScript Vis_Dropdown
category:"Mikes"
toolTip:"Vis_dropdown"
(
if $.visibility != controller then $.visibility = bezier_float()
global myval
global myArray = #(0,.2 ,.3 , .4 , .6 , .8 , 1)
rollout visRollout "visibility" width:162 height:300
(
	dropdownList ddl1 "visibilty value" pos:[7,9] width:141 height:40 items: #("0%","20%","30%","40%","60%","80%","100%")
	on ddl1 selected sel do
		(
		$.visibility.controller.value = myArray[ddl1.selection]
		myval = myArray[ddl1.selection]
		)
)

		global visRollout
		try (destroyDialog visRollout) catch()
		createDialog visRollout
)