--make a basic lighting setup with a sky and a dirrectional light, all with settings I like

myPos = $.center

mySky = Skylight()
mySky.multiplier = .4

myLight = directionallight pos:[5,6,7] target:(targetObject pos:[0,0,0])

myLight.target.position = myPos
myLight.position = [0,0,500]
myLight.baseObject.castShadows = true
myLight.baseobject.shadowgenerator = areaShadow()
myLight.isSelected = true
--myLight.raytracedShadows = on
viewport.setCamera myLight