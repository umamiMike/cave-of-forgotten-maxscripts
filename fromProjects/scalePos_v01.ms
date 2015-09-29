---my little scale position script
if scalePosRoll != undefined do (destroyDialog scalePosRoll)

centerOb

--thisPos = $.position in coordsys centerOb
	
--$.position = [1949.01,-3050.65,-4196.87] in coordsys world

fn changePosOfObj theObj CenterNode = (
	
	thisPos = theObj.position in coordsys centerOb

)
	


rollout scalePosRoll "Untitled" width:162 height:59
(
	spinner spn1 "" pos:[10,9] width:53 height:16 range:[0,100,1]

	on spn1 changed val do
	(
	myString = "the val is changing! to " + spn1.value as string
		print myString
		
		)
	on spn1 buttondown do
	(
		print "the button is down!"
		centerOb = sphere position: $.center
		
		
		)
	on spn1 buttonup  do
(
	centerOb = undefined
	)
)


createDialog scalePosRoll