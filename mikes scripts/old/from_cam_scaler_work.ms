alignarray = $ as array
global pickedobj

fn alignem = 
(
for i = 1 to alignarray.count do

(
mydummy = dummy()
mydummy.pos = pickedobj.pos
alignarray[i].parent = mydummy
mydummy.name = alignarray[i].name + "scaler"
)

)

rollout alignRoll "alignRoll" width:162 height:300
(
	pickbutton btn1 "PickButton" pos:[9,6] width:130 height:27 autoDisplay:true
	
	button btn3 "align em" pos:[14,45] width:125 height:22

	on btn1 picked obj do
		(
		pickedobj = obj
		)
	on btn3 pressed do
	(
		alignem()
		)
)
if mydialog != undefined do destroydialog mydialog

mydialog = createdialog alignRoll
