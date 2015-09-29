myobjects = #()
myobjects = selection as array

for i = 1 to myobjects.count do
(

myobj = myobjects[i]


with animate on (

at time 20 (myobj.vertices[3].pos = myobj.vertices[3].pos)
at time 1  (myobj.vertices[3].pos = myobj.vertices[2].pos)
at time 20 (myobj.vertices[4].pos = myobj.vertices[4].pos)
at time 1 (myobj.vertices[4].pos = myobj.vertices[1].pos)
)


)