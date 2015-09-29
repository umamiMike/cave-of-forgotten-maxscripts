myarray = #()


for i in 1 to selection.count do(
(
	if hasproperty selection[i].position.controller[2] #seed then (append myarray selection[i].position.controller[2]) else ()
	
	)
	
)
mynoiseStrength = 3.0
for i = 1 to myarray.count do( 

--myarray[i].seed = random 0.0 5000.0
myarray[i].NoiseStrength.keys[1].value = [mynoiseStrength,mynoiseStrength,mynoiseStrength]

)
print myarray 