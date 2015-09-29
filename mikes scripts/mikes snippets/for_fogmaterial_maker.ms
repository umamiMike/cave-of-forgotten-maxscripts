--take every object in the scene that has a material and apply a mix material
if myDistanceFalloff == undefined then myDistanceFalloff = falloff()
myDistanceFalloff.type = 4
myDistanceFalloff.Texture_Output.invert = true
myBlendMat = blend()

myBlendMat.map1 =$.mat
myBlendMat.map2 = copy $.mat
myBlendMat.Mask = myDistanceFalloff
myBlendMat.map2.diffusemap = environmentMap
myBlendMat.map2.selfIllumAmount = 100
myBlendMat.map2.specularlevel = 0
$.mat = myBlendMat