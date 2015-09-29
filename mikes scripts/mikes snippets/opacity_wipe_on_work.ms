mytime = currentTime

fn makeTheWipe = 
(
 undo on
 (
		--myMat =  meditmaterials[medit.GetActiveMtlSlot()]
		myMat = $.mat
		baseMap =myMat.opacitymap
		myChecker = Checker()
		myChecker.coords.U_Tiling = 0
		myChecker.coords.V_Tiling = 0.5
		myChecker.coords.V_Offset = 0.5
		myChecker.coords.U_Offset = 1
		
		myMask = mask()
		myMask.mask = myChecker
		myMask.map = baseMap
		myMat.opacitymap = myMask
		myMat.showInViewport = true
		myMat.twoSided = on
		
		)

)

makeTheWipe()

