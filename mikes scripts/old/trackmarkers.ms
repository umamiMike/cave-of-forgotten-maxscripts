-- trackmarker placer
--
mymat = standardMaterial()
mymat.selfIllumAmount = 100
mymat.diffuse = 255 255 255
mymat.Ambient = 255 255 255
mysphere = sphere()
mysphere.mat = mymat 
mysphere.parent = $
mysphere.radius = .5
myEditpoly = Edit_Poly ()
addModifier $ myEditpoly
n = $.numverts
    for i = 1 to n do (
	c = instance mysphere;
	c.pos = $.verts[i].pos
	)
delete mysphere

deleteModifier $ myEditpoly