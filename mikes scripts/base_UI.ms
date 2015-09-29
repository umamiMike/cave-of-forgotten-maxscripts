
global myRoll
global  my_floater

rollout myRoll "rolloutname" width:225 height:101
(
)

if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "myFlotaerName" 300 150
			addRollout myRoll my_floater
			 
