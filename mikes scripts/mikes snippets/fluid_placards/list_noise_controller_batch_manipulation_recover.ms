myobj = $ as array


for i = 1 to myobj.count do
(

--myobj[i].position.controller[2].seed = random 1 5000
--myobj[i].rotation.controller[2].seed = random 1 5000
myran = random .2 .087
--myobj[i].position.controller[2].noise_Strength = [0.1,0.1,0.1]
myobj[i].rotation.controller[2].noise_Strength = [myran,myran,myran]
myobj[i].rotation.controller.weight[2] = 100
myobj[i].rotation.controller[2].frequency = random .012 .005
--set active controller
--myobj[i].position.controller.active = 1
--myobj[i].rotation.controller.active = 1

-- this is to change the wight of the rotation noise controller
--myobj[i].rotation.controller.weight[2] = 5.0
)