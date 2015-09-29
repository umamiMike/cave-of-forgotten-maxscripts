macroScript splinebranch_maker
	category:"Mikes"
	toolTip:"spline branch maker"

(



global thepartSystem
global baseWind
global theDrag
global scalar
global baseSpray
global myParticleArray = #()

function randomScalar = 

(

random 0.0 1.00 * 8



)

function Makethesystems =
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

function MaketheParticles = 

(
baseSpray.seed = random 0 255
count = particleCount baseSpray
splineArray = #()
for i = 1 to count by 1 do
(
	ss = splineShape()
	

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
	append myParticleArray ss
		ss.baseobject.renderable = true
	    ss.thickness = 1
		ss.mapCoords = true
		ss.steps = 2
)



)

rollout my_Rollout "Spline Branch Maker" width:160 height:276
(
	button spacewarpbutton "make space warps" pos:[8,4] width:144 height:27
	button branchbutton "make the branches" pos:[11,48] width:139 height:19
	button deletebutton "delete the branches" pos:[11,100] width:139 height:19

	on spacewarpbutton pressed do
		Makethesystems()
	on branchbutton pressed do
		makeTheParticles()
	on deletebutton pressed do
		for i = 1 to myParticlearray.count do
		(delete myParticleArray[i])

)

if my_floater != undefined then CloseRolloutFloater my_floater
		my_floater = newRolloutFloater "SplineBranch_maker" 265 75
		addRollout my_rollout my_floater



)