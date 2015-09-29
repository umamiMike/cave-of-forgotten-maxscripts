newSpray.isSelected = true
newSpray.seed = random 0 200
count = $.Total_Number
splineArray = #()
for i = 1 to count by 1 do
(
	ss = splineShape()
	ss
	ss.sides = 4
	ss.angle = 45.0
	

	addNewSpline ss
	for t = 0 to 8 do
	(
		at time t 
		(

		 pos = particlePos $ i
		 if pos != undefined do
		 addKnot ss 1 #smooth #curve pos
		
		)
	)
	updateShape ss
	ss
		ss.baseobject.renderable = true
	    ss.thickness = 1
		ss.mapCoords = true
		ss.steps = 0
)
