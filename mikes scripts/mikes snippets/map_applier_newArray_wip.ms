-- little script that will take a selected map and apply it to selected objects material

global myMatProp 
global myMap
myMapArray = #(ambient,Diffuse,specular,specularLevel,glossiness,selfIllumMap,opacity,filter,Bump,Reflection,Refraction,Displacement)
myMapArrayasString = #()

for i = 1 to myMapArray.count.do
(
append myMapArrayasString myMapArray[i]. as string
)

rollout mapapplierRollout "map Applier" width:162 height:300
(
	mapButton btn1 "Map to Apply" pos:[6,7] width:83 height:17
	dropdownList ddl1 "material property" pos:[3,38] width:94 height:40 items:#("ambient", "Diffuse", "specular", "specularLevel", "glossiness", "selfIllumMap", "opacity", "filter", "Bump", "Reflection", "Refraction", "Displacement")
	button btn8 "Apply" pos:[5,86] width:101 height:21
	on btn1 picked texmap do
	(
		myMap = btn1.map
		)
	on ddl1 selected sel do
	(
	myMatProp = ddl1.selection
	)
	on btn8 pressed  do
	(
	
			for i = 1 to selection.count do
				(
				if selection[i].material != undefined do
				(
				if hasProperty selection[i].material "materialList" == true then
				(
				for l = 1 to selection[i].material.numsubs do
					(
					selection[i].material.material[l].maps[myMatProp] = myMap
					)
				)
				else
				(
				selection[i].material.maps[myMatProp] = myMap
				)
				)
				)
	)
)
		global romapApplier
		try (destroyDialog romapApplier) catch()
		createDialog mapApplierRollout
		
