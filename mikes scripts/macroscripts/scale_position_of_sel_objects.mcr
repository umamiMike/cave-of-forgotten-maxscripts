
macroScript scalepos
	category:"Mikes"
	toolTip:"scale the position of selected objects"
	
(	
(
 	-- Globals
 	
 	global scaleObjectPositions
 	
 	try(destroyDialog scaleObjectPositions)catch()
 	
 	-- Private Globals
 	
 	local scriptName = "Scale Object Positions"
 	local version = 1.00
 	
 	local dWidth = 175
 	local bw = (dWidth - 20) / 2.08
 	local fw = 45
 	local al = #center
 	local os = [-2,0]
 	local nowhere = [0,0,0]
 	local noMove = 100
 	
 	local ext = 99999999
 	
 	-- Private Global Functions
 	
 	fn constructRolloutName =
 	(
 		ver = version as string
 		if ver.count < 4 then ver += "0"
 		" " + scriptName + " " + ver
 	)
 	
 	-- Rollouts
 	
 rollout scaleObjectPositions (constructRolloutName())
 (
 	local sel
 	local mid
 	local vecs
 	local starts
 	local goFlag = false
 	local count
 	local allSpinners
 	
 	Group "Scale Group"
 	(
 	spinner spn_x "X:" range:[-ext,ext,100] type:#float fieldwidth:fw across:2 align:al offset:os
 	spinner spn_xy "XY:" range:[-ext,ext,100] type:#float fieldwidth:fw align:al
 	spinner spn_y "Y:" range:[-ext,ext,100] type:#float fieldwidth:fw across:2 align:al offset:os
 	spinner spn_yz "YZ:" range:[-ext,ext,100] type:#float fieldwidth:fw align:al
 	spinner spn_z "Z:" range:[-ext,ext,100] type:#float fieldwidth:fw across:2 align:al offset:os
 	spinner spn_zx "XZ:" range:[-ext,ext,100] type:#float fieldwidth:fw align:al
 	label lab_spacer "" across:2
 	spinner spn_xyz "XYZ:" range:[-ext,ext,100] type:#float fieldwidth:fw align:al offset:[-4,0]
 	
 	radiobuttons rdo_mid "Middle Point:" labels:#("Selection Center","Average Pivot Position") align:#Left offset:[0,-20]
 	
 	button btn_undo "Undo" width:bw align:al across:2
 	button btn_redo "Redo" width:bw align:al
 	)
 	
 	-- Local Rollout Functions
 	
 	fn resetMove =
 	(
 		for i = 1 to count do sel[i].pos = starts[i]
 	)-- end resetMove function
 	
 	fn sortLinkedObjs arr = -- needed for when the spinners are zeroed out
 	(
 		--collect all unlinked objects
 		tempArr = for a in arr where a.children.count == 0 AND a.parent == undefined collect a
 		--collect all objects with parents but no children and join with the array 'tempArr'
 		join tempArr (for a in arr where a.children.count == 0 AND a.parent != undefined collect a)
 		--go through all items in tempArr and append their parents to tempArr. Should work recursively.
 		for t in tempArr where ((findItem arr t.parent) > 0) do append tempArr t.parent
 		--remove duplicate objects
 		for i = tempArr.count to 1 by -1 where (index = findItem tempArr tempArr[i]) > 0 AND
 			index != i do deleteItem tempArr index
 		--reverse the array order
 		sortedArray = for i = tempArr.count to 1 by -1 collect tempArr[i]
 		
 		sortedArray
 	)-- end sortLinkedObjs function
 	
 	fn getCenterPoint =
 	(
 		if rdo_mid.state == 1 then selection.center
 		else
 		(
 			mid = [0,0,0]
 			for s in selection do mid += s.pos
 			mid / selection.count
 		)
 	)-- end getCenterPoint function
 	
 	fn initValues =
 	(
 		sel = sortLinkedObjs (selection as array)
 		mid = getCenterPoint()
 		vecs = for s in sel collect /*normalize*/ (s.pos - mid)
 		starts = for s in sel collect s.pos
 		goFlag = true
 		count = sel.count
 		flagForeground sel true
 	)-- end initValues function
 	
 	fn scaleMoveObjects factor =
 	(
 		factor /= 100.0
 		for i = 1 to count do sel[i].pos = vecs[i] * factor + mid
 	)-- end scaleMoveObjects function
 	
 	mapped fn resetSpinners s = s.value = 100 -- end scaleMoveObjects function
 	
 	fn btn_up rcFlag =
 	(
 		if goFlag AND rcFlag then max undo
 		goFlag = false
 		resetSpinners allSpinners
 	)-- end btn_up function
 	
 	fn btn_Down = 
 	(
 		if selection.count > 1 then
 		(
 			-- Fake the undo buffer by 'moving' to the same positions
 			undo "Scale Object Positions" on move selection nowhere
 			initValues()
 		)
 		else goFlag = false
 	)-- end btn_Down function
 	
 	-- Rollout Event Handlers
 	
 	on spn_x changed val do if goFlag do scaleMoveObjects [val,noMove,noMove]
 	on spn_xy changed val do if goFlag do scaleMoveObjects [val,val,noMove]
 	on spn_y changed val do if goFlag do scaleMoveObjects [noMove,val,noMove]
 	on spn_yz changed val do if goFlag do scaleMoveObjects [noMove,val,val]
 	on spn_z changed val do if goFlag do scaleMoveObjects [noMove,noMove,val]
 	on spn_zx changed val do if goFlag do scaleMoveObjects [val,noMove,val]
 	on spn_xyz changed val do if goFlag do scaleMoveObjects [val,val,val]
 	
 	on spn_x buttondown do btn_Down()
 	on spn_xy buttondown do btn_Down()
 	on spn_y buttondown do btn_Down()
 	on spn_yz buttondown do btn_Down()
 	on spn_z buttondown do btn_Down()
 	on spn_zx buttondown do btn_Down()
 	on spn_xyz buttondown do btn_Down()
 	
 	on spn_x buttonup rightClickFlag do btn_up rightClickFlag
 	on spn_xy buttonup rightClickFlag do btn_up rightClickFlag
 	on spn_y buttonup rightClickFlag do btn_up rightClickFlag
 	on spn_yz buttonup rightClickFlag do btn_up rightClickFlag
 	on spn_z buttonup rightClickFlag do btn_up rightClickFlag
 	on spn_zx buttonup rightClickFlag do btn_up rightClickFlag
 	on spn_xyz buttonup rightClickFlag do btn_up rightClickFlag
 	
 	on btn_undo pressed do
 	(
 		max undo
 	)
 	on btn_redo pressed do
 	(
 		max redo
 	)
 	
 	on scaleObjectPositions open do
 	(
 		allSpinners = for c in scaleObjectPositions.controls where classof c == SpinnerControl collect c
 	)
 )-- end scaleObjectPositions rollout definition
 	
 	createDialog scaleObjectPositions width:dWidth style:#(#style_toolwindow, #style_border, #style_sysmenu)
 )
			
)
