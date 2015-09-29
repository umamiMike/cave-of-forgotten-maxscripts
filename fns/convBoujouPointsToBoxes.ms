bjPoints = #()
bjBoxes = #()

fn gatherBoujouPoints = (
	undo on
	for i in objects do (--loop to gather all boujou points in the scene and put them in an array
	
	
		if classof i  == Point and i.parent != undefined and i.parent.name == "reference_points" do (
			append bjPoints i
			--print i.name
		)
	
	)
		
	selectionSets["boujouPoints"] = bjPoints
)


fn makeTheBoxes = (
	undo On 
	myBox = box()
myBox.name = "PointSizeMaster"
for i in bjPoints do (
	

	useBox = instance myBox
	useBox.center = i.pos
	useBox.pivot = useBox.center
	append bjBoxes useBox
	
	
)
selectionSets["boujouBoxes"] = bjBoxes

)

fn makeTheOriginPoint = (
	
	for i in objects do (
		if superclassof i == camera do(
			myPoint = Point()
			myPoint.pos = i.pos
			temp = i.parent
		temp.parent = myPoint
			
		)
		
	)
	
	
	
	
)