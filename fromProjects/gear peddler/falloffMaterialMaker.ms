

myGlobFalloff = falloff() 
myGlobFalloff.type = 4
myGlobFalloff.name =  "myGlobalFalloff"
myObjects = selection as array


for i = 1 to myObjects.count do(

myobj = myObjects[i]
print myobj.name

myOriginalMat = myobj.mat
myNewMat = multimaterial()
myNewMat[1] = myOriginalMat
myNewMat[2] = copy myOriginalMat
myNewMat[2].diffusemap = myGlobFalloff
myObj.mat = myNewMat


)