-- deleteFromListController.ms
--
-- Example from MAXScriptHelp under "List Controllers"
-- By Larry Minton

-- creates new list controller from old, deleting indexed controller 
-- returns the new controller 
fn deleteFromListController list_cont index = 
( 
-- create new list controller based on class of input list controller 
new_cont=execute ((classof list_cont as string) + "()") 
-- for each subAnim (except the last, which is the phantom "available" 
-- controller).. 
for i=1 to (list_cont.numSubs-1) do 
-- if not the sub-controller to delete 
if i != index do 
-- instance the sub-controller (contained in the .object property of 
-- the subAnim) to the new list controller 
new_cont.available.controller=list_cont[i].object 
-- and return the new list controller 
return new_cont 
) 
-- 
-- example usage (obj.pos already has list controller) 
--obj.pos.controller = deleteFromListController obj.pos.controller 2 
--globalTracks.float=deleteFromListController globalTracks.float 1
