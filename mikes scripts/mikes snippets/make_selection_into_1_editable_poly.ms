mySelArray = selection as array

convertToPoly mySelArray[1]

for i = 2 to mySelArray.count do
(

mySelArray[1].EditablePoly.attach mySelArray[i] mySelArray[1]

)