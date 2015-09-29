--from a series of create plates
myObjects = selection as array

for i = 1 to myObjects.count do(

myobj = myObjects[i]
print myobj.name

myOriginalMat = myobj.mat
myNewBitMap = copy myOriginalMat.diffusemap 
myNewBitMap.monoOutput = 0
myNewDiffuseMap = Mix()
myNewDiffuseMap.mask = myNewBitMap
myobj.mat.diffusemap = myNewDiffuseMap

)