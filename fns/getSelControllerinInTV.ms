--myTv = trackViews.currentTrackView 

--myCont = myTv.getselected 2

function getSelControllersInTV = (
myTv = trackViews.currentTrackView 
myConts = #()

for i = 1 to 20 do (
	if myTv.getselected i != undefined then (
	thisCont = myTv.getselected i
	append myConts thisCont
	)
	
	else (print "Elsed")


)
return myConts	
)
	
	