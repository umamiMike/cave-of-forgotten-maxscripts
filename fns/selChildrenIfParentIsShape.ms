function selChildrenIfShape = (
myObs = #()
if selection.count  > 0 do (
myObs = for i in selection[1].children where superclassof  selection[1] == shape collect i
	

)
if myObs.count == 0 then(undefined)

else(myObs)

)