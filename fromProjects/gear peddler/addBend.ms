--from a series of create plates
myObjects = selection as array

for i = 1 to myObjects.count do(

myobj = myObjects[i]
print myobj
--make the widthsegs of the plane 50
myobj.baseobject.widthsegs = 50
--add a bend
mybend = bend()
--set it correctly for my use
mybend.BendAxis = 0
mybend.bendDir = 90
mybend.angle = 37
myUseBend = copy mybend
--add the modifier to the object as a copy of the original, for multiple uses

addmodifier  myobj myUseBend 




)