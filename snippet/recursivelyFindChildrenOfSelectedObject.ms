parentAndChildren = #()

fn getObjs theObject =

(

if theObject.children != undefined do 	
	append parentAndChildren theObject 

for i in theObject.children do 

getObjs i

)