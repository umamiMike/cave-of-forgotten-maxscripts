try(destroydialog selByStringRoll) catch()

rollout selByStringRoll "Select By String" width:280 height:50
(
	button SelbyStringBtn "Select by String" pos:[6,18] width:100 height:20  
  
	editText edt1 "" pos:[123,18] width:141 height:16
 
	on selbystringbtn pressed do(
		
thePattern = "*"+edt1.text+"*"
myObs = for i in objects where matchPattern i.name pattern:thePattern collect i

select myObs
)


)

createdialog selByStringRoll