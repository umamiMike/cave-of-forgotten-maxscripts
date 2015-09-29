-- put a material or a map in the current material editor slot
meditmaterials[medit.GetActiveMtlSlot()] = myfalloffArray[1] --whatever map or material you want

--collect all falloff maps in to an array
mixArray = for i in (getClassInstances falloff) collect i

fn getNodeID node = 
(
 n = trimright node.name "0123456789"
 id = substring node.name (n.count+1) -1
 if id.count > 0 then id as integer else -1 
)
fn makeSuffix id places:4 = if iskindof id integer do
(
 id = id as string
 while id.count < places do id = "0" + id
 id
)
fn findByID list id asnode:on = 
(
 local n = 0
 for k=1 to list.count while n == 0 where isvalidnode (node = list[k]) and matchpattern node.name pattern:("*" + id) do
 (
  if asnode then n = node else n = k
 )
 n
)
fn sortByID n1 n2 = 
(
 id1 = getNodeID n1
 id2 = getNodeID n2
 if id1 < id2 then -1 else if id1 > id2 then 1 else 0
)


