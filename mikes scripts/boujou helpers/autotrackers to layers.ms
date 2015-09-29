myAutoTrackers = #()
myArray = objects as array
for i = 1 to myarray.count do

(
myname = myarray[i].name as string

my = matchPattern myname pattern:"auto_*"
if my == true do
(
append myAutoTrackers myarray[i]

)
)

mylayer = layerManager.newLayer()
mylayer.setname "Auto"


for i = 1 to myAutoTrackers.count do
(

mylayer.addnode myAutoTrackers[i]
)