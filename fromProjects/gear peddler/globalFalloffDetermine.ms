global myGlobFalloff = undefined
myfalloffArray = #()
myfalloffArray = for i in (getClassInstances falloff)  collect i

for i = 1 to myFalloffArray.count  do (

if myFalloffArray[i].name != "myGlobalFalloff" then (print myFalloffArray[i].name) else (global myGlobFalloff = myFalloffArray[i])


)
