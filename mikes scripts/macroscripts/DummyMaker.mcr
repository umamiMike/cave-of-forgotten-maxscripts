macroScript DummyMaker Icon:#("mc_dummymaker",1)
	category:"Umami"
	toolTip:"Make a Goddamned dummy"
(

	
	

rollout myroll "Untitled" width:162 height:300
(
	editText edt1 "" pos:[10,8] width:139 height:23
	on edt1 entered text do
	(
	
	mydummy = dummy()
	mydummy.name = edt1.text
	mydummy.pos = $.center
	mydummy.boxsize = $.max - $.min
	for i = 1 to selection.count do 
	(
	selection[i].parent = mydummy
	
	)
	mydummy.isSelected = true
	)
)

myFloater = newRolloutFloater "DummyMaker" 265 265
addrollout myroll myFloater
)