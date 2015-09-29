myobj = $ as array


for i = 1 to myobj.count do
(

--myobj[i].position.controller[2].seed = random 1 5000


--myobj[i].position.controller.active = 1
myobj[i].position.controller[2].noise_Strength = [0,0,0]--[20,20,20]
--myobj[i].position.controller[2].frequency = .01
--myobj[i].position[3] = 200.0

--myobj[i].rotation.controller[2].noise_Strength = [0.349066,0.349066,0.349066]
myobj[i].rotation.controller[2].noise_Strength = [0,0,0]
--myobj[i].rotation.controller[2].frequency = .01
--myobj[i].rotation.controller[2].seed = random 1 5000

--set active controller

--myobj[i].rotation.controller.active = 1

-- this is to change the wight of the rotation noise controller
--myobj[i].rotation.controller.weight[2] = 5.0
)