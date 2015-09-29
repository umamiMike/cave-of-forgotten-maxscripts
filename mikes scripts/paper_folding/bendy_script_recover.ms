global endFrame = 20
global fadetime = 5

myObj = $

chamferBend = bend()
chamferBend.FromTo = on
chamferBend.BendTo = 0.75
chamferBend.BendFrom = 0
chamferBend.BendAxis = 1
chamferBend.bendDir = 90





myObj.edgeChamfer = 0.25
myObj.EditablePoly.buttonOp #Chamfer
myObj.edgeChamfer = 0.125
myObj.EditablePoly.buttonOp #Chamfer
modPanel.setCurrentObject myObj.baseObject

--modPanel.addModToSelection (chamferBend) ui:on
addmodifier myObj (chamferBend) ui:on

subobjectLevel = 0


animate on
		
			(
				at time 0f (chamferBend.angle = 180)
				at time (currentTime) (chamferBend.angle = 180)
				at time (currentTime + endFrame) (chamferBend.angle = 0)
			)