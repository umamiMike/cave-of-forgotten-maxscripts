fn collectMyChildren obj includeParent:true =
(
-- start collecting direct children of <obj>
myChildren = #(obj)

-- add children and their children etc recursively
i = 0
while i < myChildren.count do
(
i += 1
join myChildren myChildren[i].children
)

-- remove initial object if <includeParent> == false
if not includeParent then deleteitem myChildren 1

-- return array containing children
myChildren
)

--select (collectMyChildren $ includeParent:false)

myObjects = collectMyChildren $ includeParent:true