
for x = 1 to selection.count do
(
splineArray = #()
count = particleCount selection[x]

for i = 1 to count do
	(
		ss = splineShape()
		ss

		addNewSpline ss
		for t = 0 to 100 do
		(
			at time t
			(
				pos = particlePos selection[x] 1
				addKnot ss 1 #smooth #curve pos
			)
		)
	updateShape ss
	ss
		ss.baseobject.renderable = true
		ss.thickness = random .1 3
		ss.name = "branch"
)
)