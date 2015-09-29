i = 1
  
  ilayer = layerManager.getLayer i
  layerName = ilayer.name 
  layer = ILayerManager.getLayerObject i
  layerNodes = refs.dependents layer
  format "Layer: %; nodes: %\n" layerName layerNodes

