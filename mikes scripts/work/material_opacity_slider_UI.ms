global MatOpacityRoll
global mymat
rollout MatOpacityRoll "Untitled" width:295 height:104
(
	slider sld1 "opacity" pos:[6,51] width:276 height:44 range:[0,100,50]
	materialButton btn3 "select the material" pos:[12,9] width:161 height:35
	on sld1 changed val do
	(

			if mymat != undefined then (mymat.opacity = sld1.value)

		)
	on btn3 picked mtl do
		mymat = btn3.material
)


DestroyDialog MatOpacityRoll
CreateDialog MatOpacityRoll
