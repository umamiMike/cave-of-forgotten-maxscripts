branchSpray = $
myTime = 60
for i = 1 to $.Total_Number do
(
		at time myTime
		(
			pos = particlePos $ i
			copy branchSpray
			branchSpray.pos = pos
			branchSpray.name = "branchy"

		)
)


-- so far only copies the pcloud...doesnt generate splines