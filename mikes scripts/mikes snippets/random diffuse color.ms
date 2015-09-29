for i = 1 to selection.count do

(
if selection[i].material.diffuse != undefined then
(
	selection[i].material.diffuseMapEnable = off
	selection[i].material.selfIllumAmount = 100
	selection[i].material.specularlevel = 0

				RanR=random 0 255
				RanG=random 0 255
				RanB=random 0 255
				selection[i].material.diffuse=[RanR,RanG,RanB]
			
)
)