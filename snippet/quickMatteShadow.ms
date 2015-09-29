
persistent global theVisibleObjects = #() --define array for the visible Objects
persistent global theVisibleObjectsOriginalMat = #()

myMatteShadMat = matteShadow()
myMatteShadMat.receiveShadows = off




--filter to find out, out of ALL object, what are not hidden and not selected and make an append them to the theVisibleObjects array
for i in objects where i.ishidden == false and i.isselected == false do (append theVisibleObjects i)
undo on
for i in theVisibleObjects do (--set all of the objects to a matteshadow object....
	
	append theVisibleObjectsMat i.mat
	i.mat = myMatteShadMat
	
	)
thePath = getFilenamePath rendOutputFilename
theType = getFilenameType  rendOutputFilename
theFileToRender = thePath + selection[1].name + theType
	
render()-- fromFrame:rendStart toFrame:rendEnd outputfile:theFileToRender -- and then render

	
	

for i = 1 to theVisibleObjects.count do (theVisibleObjects[i].mat = theVisibleObjectsOriginalMat[i])