--- maxscript to output diffuse color in rgb format to illustrator or photoshop
for i = 1 to sceneMaterials.count do
(
--mymat = meditmaterials[medit.GetActiveMtlSlot()]
--mymat.diffusecolor

	format "%, %\n  " sceneMaterials[i].name sceneMaterials[i].diffusecolor

)