--myFalloff = falloff()
--myFalloff.type = 4



for x = 2 to myarray.count do
(
--quickgroup[x].height = random 3 300
--quickgroup[x].modifiers[#Bend].BendAngle = random -100 100
--quickgroup[x].modifiers[#Bend].BendDir = random -20 100
--quickgroup[x].material.samplerUseGlobal = off
--quickgroup[x].material.samplerEnable = on
--quickgroup[x].baseobject.steps = 2
--quickgroup[x].material.opacityMapAmount = 40
--quickgroup[x].material.diffuseMapEnable = off
--quickgroup[x].material.selfIllumAmount = 100
--quickgroup[x].material.Diffuse = color 255 255 255
--quickgroup[x].material.Ambient = color 255 255 255
--quickgroup[x].material.opacityMapAmount = 100
--quickgroup[x].material.diffusemap = myFalloff
--myarray[x].material.diffusemap = copy myarray[1].material.diffusemap
myarray[x].mat.diffusemap.starttime = x*60
)
