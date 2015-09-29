animated_props = #()

fn getAnimatedProps theObject =

(

if try(theObject.controller != undefined)catch(false) do 

append animated_props theObject 

for i = 1 to theObject.numSubs do 

getAnimatedProps theObject[i]

)

getAnimatedProps $

