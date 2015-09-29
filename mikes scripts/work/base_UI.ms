
global myRoll
global  my_floater

rollout myRoll "rolloutname" width:200 height:150
(

)

if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "myFlotaerName" 200 150
			addRollout myRoll my_floater
			 
