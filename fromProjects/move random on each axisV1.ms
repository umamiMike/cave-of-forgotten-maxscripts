function moveTheOb ob ax amt theTime = (
	--print (ax)
			addNewKey ob.position.controller.keys theTime
with 	animate on (
	case ax of
	(
	1: (at time theTime 
		ob.position.controller.x_position += amt)
	2: (at time theTime 
		ob.position.controller.y_position += amt
		)
	3: (at time theTime 
		ob.position.controller.z_position += amt)
	)
)
	
	)

fn RandomSequence Num=
(    
    theSequence = for i=1 to Num collect i    -- Create Initial Sequence
    theResult =#() -- Create empty array for the result
    
    -- Loop
    range = theSequence.count+1
    for j=1 to theSequence.count do
    (    
        range -=1
        rand = random 1 range -- Create  random  start with higher range value until empty
        append theResult theSequence[rand]    -- Insert to the Result
        index = finditem theSequence theSequence[rand]    -- Check the index of result in thesequence
        deleteitem theSequence index     -- Then delete item in theSequence with indexed number
    )    -- End Loop
    theResult  -- Output the result
)

	
fn doIt ob loops = (
	theRanSeq = #()
	for i = 1 to loops do(
	theRanSeq += randomSequence 3
	)
		
		--print (theRanSeq)
	
	for i = 1 to loops do (
		
		moveTheOb ob theRanSeq[i] (random -1000 1000) (currenttime+(3*i)))
	)