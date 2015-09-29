myArray = selection as array
for i = 1 to myArray.count do
(
myobj = myArray[i]
mycount= 2
movekeys myobj  (i * mycount)
--deselect selection[1]
)