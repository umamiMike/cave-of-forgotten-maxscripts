newSpray.isSelected = true
count = particleCount $

myTime = 60
for i = 1 to count/2 do
(
		at time myTime
		(
			pos = particlePos $ i
			branchspray = copy newSpray
			branchspray.pos = pos
			branchspray.quantityMethod = 1
			branchspray.Total_Number = 10
			branchspray.viewPercent = 100
			bindSpacewarp branchspray newWind
			bindSpacewarp branchspray newDrag


		)
)


-- so far only copies the pcloud...doesnt generate splines