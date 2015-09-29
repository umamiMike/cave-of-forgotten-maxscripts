myspline = $
myLength = curvelength mySpline 1

mySpline = selection[i]
myPos = getKnotPoint mySpline 1 1
--mySpline.pivot = myPos

ss = splineshape()

addNewSpline ss

for i = 1 to mylength as integer by 4 do

(
addKnot ss 1 #smooth #curve [0,0,i]

)
updateshape ss
--ss.pos = mypos
--myspline.transform = (matrix3 [1,0,0] [0,1,0] [0,0,1] [0,0,0])
--ss.transform = (matrix3 [1,0,0] [0,1,0] [0,0,1] [0,0,0])
--mypathdef = PathDeform ()
mypathdef = SpacePathDeform ()
mypathdef.path = myspline
addmodifier ss mypathdef

ss.parent = myspline

select ss