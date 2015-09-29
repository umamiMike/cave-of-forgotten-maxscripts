global volselmap

rollout myRoll "volselpush yo" width:162 height:300
(
	mapButton btn1 "select the map" pos:[8,6] width:135 height:22
	button btn2 "do it" pos:[11,41] width:134 height:25
	on btn1 picked texmap do
		volselmap = btn1.map
	on btn2 pressed  do
		(
			mypush = push()
myVolSel = Volumeselect()
myVolSel.level = 1
myVolSel.volume = 4
myVolSel.texture = volselmap
 

addmodifier $ myVolSel
addmodifier $ mypush
meditmaterials[medit.GetActiveMtlSlot()] = volselmap
			)
)

global myFloater = newRolloutFloater "VolSel Push" 265 265
addRollout myRoll myFloater