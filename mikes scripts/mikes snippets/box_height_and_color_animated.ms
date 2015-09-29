global myRan
fn myRannum = (myRan = random 0 255)

for i = 1 to selection.count do
(
selection[i].mat = standardmaterial()

for a = 1 to 100 by 2 do
(
animate on
(
--height keys
at time (currentTime) (selection[i].height = selection[i].height+(random -10 10)*10 )
at time (currentTime + a) (selection[i].height = (random 1 10)*10 )
--color keys
myRannum()
at time (currentTime) (selection[i].mat.diffuse = (color myRan myRan myRan))
at time (currentTime + a) (selection[i].mat.diffuse = (color myRan myRan myRan))
)
)

)