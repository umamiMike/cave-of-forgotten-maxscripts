
meshSelected =  $ -- object to create contours of

minZ = meshSelected.min.x -- get min and max Z positions

maxZ = meshSelected.max.x

numLevels = 3 -- the number of contours

delta = (maxZ - minZ) / (numLevels + 1) -- the number of steps

for currentZ = minZ to maxZ by delta do -- start loop...

(

s = section pos:[0,0,currentZ] rotation: (quat 0 -0.707107 0 0.707107)-- create Section
s.name = "bitchwhore"
max views redraw -- this line is needed to get around the problem

convertToSplineShape s -- convert Section to SplineShape

--s.renderable = true -- set to renderable

)

