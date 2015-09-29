
cols = 6
theobjs = 34
for i = 1 to theobjs do(
	index = mod i cols
if  mod i cols  == 0 then (print i) else print "Fuck Yeah"
)


myObs = selection as array

for i = 2 to myObs.count do(
	prevOb = myObs[i-1]
	ob = myObs[i]
	if mod i cols == 0 then ()
	else (
		
		ob.pos = prevOb.pos
		ob.pos.x = prevOb.pos + prevOb.max[1]
		
		
	)