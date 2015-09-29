--take two objects and swap their positions
for i = 2 to selection.count by 2 do (
	
	switchPos i 
	
)
fn switchPos i  = (
	
	ob2 = selection[i]
	ob1 = selection[i-1]
	offSet = 60f
	firstPos = ob1.transform
	secondPos = ob2.transform

	
	animateThem ob1 ob2 firstPos secondPos offSet

)


function animateThem ob1 ob2 firstPos secondPos offSet = (
	animate on 
		
	(
		
	at time (currentTime) (
		ob1.transform = firstPos 
		ob2.transform = firstPos
		)
	at time (currentTime + offset) (
		
		ob2.transform = secondPos
		ob1.transform = secondPos
		)
		
	)
	
)
	