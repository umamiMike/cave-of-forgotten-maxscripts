
--This Routine will delete ALL modifiers that are materialmodifiers that have the name "FalloffMatSwitch"
myNonFalloffObjs = #()

myfalloffArray = #()
myfalloffArray = for i in (getClassInstances falloff)  collect i
global myGlobFalloff = undefined

for i = 1 to myfalloffArray.count do

(
 if myFalloffArray[i].name == "myGlobalFalloff" then 

(myGlobFalloff = myFalloffArray[i]
exit)

else(
myGlobFalloff = falloff() 
myGlobFalloff.type = 4
myGlobFalloff.name = "myGlobalFalloff"
)

)

-- Make the myNonFalloffObjs array--
for i = 1 to objects.count do
(
for k = 1 to objects[i].modifiers.count do
	(
	myMod = objects[i].modifiers[k]
	if classof myMod == Materialmodifier and (myMod.name  == "FalloffMatSwitch")  then (append myNonFalloffObjs objects[i])
	
	)

)
----------



--function to make the falloff material on all objects in the myNonFalloffObjs array
function MakeFalloffMaterial = 
(

	for i = 1 to myNonFalloffObjs.count do(
	
	myobj = myNonFalloffObjs[i]
	print myobj.name
	
	myOriginalMat = myobj.mat
	myNewMat = multimaterial()
	myNewMat.name = myobj.name + "multiMat"
	myNewMat[1] = myOriginalMat
	myNewMat[2] = copy myOriginalMat
	myNewMat[2].name = myobj.name + "
	myNewMat[2].diffusemap = myGlobFalloff
	myObj.mat = myNewMat
	

)





)