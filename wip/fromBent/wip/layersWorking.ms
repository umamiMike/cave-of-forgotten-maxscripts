myLayer = layerManager.getLayer 1
layerRT = myLayer.layerAsRefTarg
myObsRef = refs.dependents layerRT
myObs = for i in myObsRef where i collect i
selectionSets[myLayer.name] = myObs
	
