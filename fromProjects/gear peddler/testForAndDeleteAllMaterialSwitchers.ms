
--This Routine will delete ALL modifiers that are materialmodifiers that have the name "FalloffMatSwitch"


for i = 1 to objects.count do
(
for k = 1 to objects[i].modifiers.count do
	(
	myMod = objects[i].modifiers[k]
	if classof myMod == Materialmodifier and (myMod.name  == "FalloffMatSwitch")  then (deletemodifier objects[i] myMod)
	
	)

)