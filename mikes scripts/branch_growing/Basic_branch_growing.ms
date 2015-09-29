for i = 1 to selection.count do
(

--Centerpos = getKnotPoint selection[i] 1 1
myDeform = SpacePathDeform()
myCyl = Cylinder()
myCyl.height = 0.01
myCyl.radius = 2
myCyl.heightsegs = 29
myCyl.mapcoords = on
myCyl.transform = selection[i].transform
addModifier myCyl myDeform
myDeform.path = selection[i]
myDeform.axis = 2
myCyl.name = "branch"+i as string
myCyl.parent = selection[i]

animate on

(
at time 0f (myCyl.height = 0)
at time 1f (myCyl.visibility = off)
at time 2f (myCyl.visibility = on)
at time 30f (myCyl.height = 200)
)


)

