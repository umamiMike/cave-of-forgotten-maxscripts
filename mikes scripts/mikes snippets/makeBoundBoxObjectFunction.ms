--make a box out of the bounding box of the selection
--put a lattice on the box
--make the box NOT renderable

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


)

makeBBox()