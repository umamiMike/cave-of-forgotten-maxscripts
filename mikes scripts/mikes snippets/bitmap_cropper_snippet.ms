myarray = selection as array
undo on
(
for i = 1 to myarray.count do
(
if  myarray[i].mat.diffusemap != undefined then
(
mymap =  myarray[i].mat.diffusemap
 mymap.clipw = .9
 mymap.cliph = .9
 mymap.clipu = .05
 mymap.clipv = .05
 
mymap.apply = on
)
)

)


