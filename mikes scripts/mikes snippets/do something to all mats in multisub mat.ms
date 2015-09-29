myMat = meditmaterials[medit.GetActiveMtlSlot()] 

for i = 1 to myMat.count do
(
	animate on
	(
	at time 0f (myMat[i].opacityMapAmount = 0)
	at time 10f (myMat[i].opacityMapAmount = 100)
	
	
	)
)