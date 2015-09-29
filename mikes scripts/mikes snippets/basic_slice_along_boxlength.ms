global mymax
global mymin
global mydim
undo on
(
for i = 1 to selection.count do
(
myobj = selection[i]
myslice = SliceModifier ()
myslice.Slice_Type = 2

mycap = Cap_Holes ()

angleArray = #(eulerAngles 90 0 0 , eulerAngles 90 90 0 , eulerAngles 90 0 90)


objtrans = myobj.transform
mysliceplane = myslice.slice_plane
mymin = myobj.min
mymax = myobj.max
mydim = mymax - mymin
mycenter = myobj.center
addmodifier myobj myslice
addmodifier myobj mycap

mynum
myslice.slice_plane.rotation = eulertoquat (angleArray[2])


animate on
(
at time 0f (mysliceplane.pos = [mydim[1]/2,0,0])
at time 20f (mysliceplane.pos = [-mydim[1]/2,0,0])
)
)

)