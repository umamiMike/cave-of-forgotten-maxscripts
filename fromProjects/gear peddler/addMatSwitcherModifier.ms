--Global Variables
global myMatSwitch = Materialmodifier ()
myMatSwitch.name = "FalloffMatSwitch"

--routine for adding modifier

for i = 1 to objects.count do(

myobj = objects[i]

addmodifier  myobj myMatSwitch




)