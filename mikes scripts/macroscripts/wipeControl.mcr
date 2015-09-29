
macroScript wipeControl
	category:"Mikes"
	toolTip:"WipeControl"
	
(	
	
global myMap
global myMapPercent
fn makeTheWipe = 
(
 undo on
 (
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
		myMap = myChecker
		)

)



rollout wipeRoll "Wiper" width:225 height:101
(
	mapButton btn1 "pick the map" pos:[94,5] width:121 height:26
	pickbutton btn5 "Pick the wipe master" pos:[90,36] width:128 height:27
	button connectbtn "connect them" pos:[88,65] width:123 height:25
	button wipebtn "make the wipe" pos:[10,5] width:78 height:31
	on btn1 picked texmap do
	(
		myMap = btn1.map
	)
	on btn5 picked obj do
	(
		myobj = btn5.object
		)
	on connectbtn pressed do
	(
		paramWire.connect myobj.pos.controller[#Percent] mymap.coords[#V_Offset] "Percent+.5"
		)
	on wipebtn pressed  do
( 
		makethewipe()
	
	)
)
wipe_floater = newRolloutFloater "Wipecontrol" 300 150
			addRollout wipeRoll wipe_floater
			
)
