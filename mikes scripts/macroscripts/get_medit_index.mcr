macroScript getMedit
	category:"Mikes"
	toolTip:"Get the Medit Index easily"


(
global myRoll
global  my_floater


rollout myroll "MeditID" width:149 height:101
(
	button btn1 "Which Medit slot am I?" pos:[17,11] width:114 height:78



	on btn1 pressed  do
		btn1.caption = medit.getActiveMtlSlot() as string
)
if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "Show Medit index"  160 125
			addRollout myRoll my_floater
			 
)