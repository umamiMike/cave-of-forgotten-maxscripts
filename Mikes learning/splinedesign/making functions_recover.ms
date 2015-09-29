global baseSpray
baseCount = $.Total_Number
splineArray = #()
------------------
--functions
----------------------
function MaketheParticles =
(
baseWind = Wind ()
baseDrag = Drag ()
baseSpray = Parray ()
baseSpray.emitter = $
baseSpray.seed = random 0 200
baseSpray.quantityMethod = 1
baseSpray.Total_Number = 50
baseSpray.isSelected = true
baseSpray.viewPercent = 100
bindSpacewarp baseSpray baseWind
bindSpacewarp baseSpray baseDrag
)



function makebasevine = 
(
for i = 1 to baseCount do
(
	ss = splineShape()
	ss
	ss.sides = 4
	ss.angle = 45.0
	

	addNewSpline ss
	for t = 0 to 100 do
	(
		at time t 
		(

		 pos = particlePos baseSpray i
		 if pos != undefined do
		 addKnot ss 1 #smooth #curve pos
		
		)
	)
	updateShape ss
	ss
		ss.baseobject.renderable = true
	    ss.thickness = .001
		ss.mapCoords = true
		ss.steps = 1
)
)




MaketheParticles()
--makebasevine()
