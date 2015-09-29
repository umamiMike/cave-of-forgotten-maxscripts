fn collectMyMaps theMap includeParent:true =
(
-- start collecting direct children of <theMap>
myMaps = #(theMap)

-- add children and their children etc recursively
i = 0
thisNumCount = getnumsubtexmaps theMap	
while i < thisNumCount do
(


	thisMap = getSubTexmap theMap i -- finding out what mat it is
	if thisMap != undefined do (append myMaps thisMap)
i += 1
)

-- remove initial theMapect if <includeParent> == false
if not includeParent then deleteitem myChildren 1

-- return array containing children
myChildren
)

--select (collectMyChildren $ includeParent:false)

mytheMapects = collectMyMaps 