hsel = selection as array
  for o in sel do
  (
  	newobj = copy o
  	newobj.name = o.name + "_VertBaked"
  	convertToMesh newobj
  	numverts = meshop.getnumverts o
  	for t =animationrange.start to animationrange.end do
  	(
  		with animate on
  		(
  			for i = 1 to numverts do
  			(
  				at time t curvert = meshop.getvert o i
  				at time t meshop.setvert newobj i curvert
  			)
  		)
  	)
	)
