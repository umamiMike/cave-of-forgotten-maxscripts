
Global MaketheParticles
Global makeBranches
Global particleCount 
-- make the particles
function MaketheParticles =
(
newWind = Wind ()
newDrag = Drag ()
newSpray = PCloud ()
newSpray.quantityMethod = 1
newSpray.Total_Number = 100
newSpray.isSelected = true
newSpray.viewPercent = 100
bindSpacewarp newSpray newWind
bindSpacewarp newSpray newDrag
)
-- Make branches

function makeBranches = 
(
newSpray.isSelected = true
newSpray.seed = random 0 200
count = particleCount $
splineArray = #()
for i = 1 to count by 2 do
(
	ss = splineShape()
	ss
	ss.sides = 4
	ss.angle = 45.0
	ss.optimize = false
	ss.steps = 0.0
	ss.name = "branch"+i as string

	addNewSpline ss
	for t = 0 to 100 do
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
	    ss.thickness = random .5 2
)
)


-- MaketheParticles()
-- makeBranches()
rollout branchRollout "Branchmaker" width:162 height:140
(
	button btn1 "make particles" pos:[7,9] width:102 height:19
	button btn2 "Make Branches" pos:[10,36] width:101 height:18
	editText particleCount "" pos:[13,71] width:87 height:21
	button btn7 "Button" pos:[112,72] width:40 height:21
	on btn1 pressed do
		MaketheParticles()
	on btn2 pressed do
		makeBranches()
	on particleCount entered text do
(
	
	)
	on btn7 pressed  do
(
	
	)
)

br_floater = newRolloutFloater "branchMaker" 250 100
addrollout branchRollout br_floater