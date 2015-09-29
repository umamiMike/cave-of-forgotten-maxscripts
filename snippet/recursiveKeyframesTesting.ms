animated_props = #()

fn getAnimatedProps theObject =

(

if try(theObject.isAnimated)catch(false) do 

append animated_props theObject 

for i = 1 to theObject.numSubs do 

getAnimatedProps theObject[i]

)

getAnimatedProps $



for i in animated_props do (
	try(
		print i
		print i.keys.count
		)
		catch(false)
		
	)