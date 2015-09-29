--make matIDs
--a variable for the object.material.opacitymap
for i = 1 to selection.count do(
myObj = selection[i]
originalMat = myObj.mat
op = originalMat.opacitymap
myMat = Blend() 
myMat.map2 = originalMat 
myMat.map1.opacitymap = op
myMat.mask = op
myMat.interactive = 1
myObj.mat = myMat

)