

rollout myRollout "Blend Maker" width:162 height:300
(
	button btn1 "add blend" pos:[8,7] width:138 height:27
	button btn2 "remove blend" pos:[8,48] width:142 height:29
	on btn1 pressed  do
(
	myMat = $.mat

myBlend = blend()

$.mat = myBlend

$.mat.map1 = myMat

$.mat.map2.opacity = 0

meditmaterials[medit.GetActiveMtlSlot()] = $.material
	)
	on btn2 pressed  do
(
	myTest = hasProperty $.mat  "map1"
	if  myTest == true then
		(
			$.mat = $.mat.map1
			meditmaterials[medit.GetActiveMtlSlot()] = $.material
		)
	else()
	)
)
destroyDialo
myFloater = newRolloutFloater "BlendMaker" 265 265
addRollout myRollout myFloater
