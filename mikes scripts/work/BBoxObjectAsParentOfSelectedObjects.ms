--make routine for finding the max value in the min array and the max array and adding THOSE together

function ParentEm mybox = (

mydummy = mybox
	for i = 1 to selection.count do 
	(
	if selection[i].parent == undefined then (selection[i].parent = mydummy)
	
	)
--	mydummy.isSelected = true

)
function makeBBox = (

myBox = box()
myDim = selection.max-selection.min
myBox.length = myDim[2]
myBox.width = myDim[1]
myBox.height = myDim[3]
mybox.pivot = mybox.center
mybox.pos = selection.center
setrenderable mybox False
mybox.boxmode = on

ParentEm mybox

)

makeBBox()