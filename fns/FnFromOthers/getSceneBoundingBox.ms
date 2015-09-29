-- getSceneBoundingBox.ms
-- 12.09.01
-- By Larry Minton
--editing to add size Mike Chastain 12-22-13
fn getSceneBoundingBox =
( struct box3_struct (minv,maxv,theSize)
local bbox
for obj in objects where not obj.ishidden do
( if bbox == undefined then
bbox = box3_struct obj.min obj.max (obj.max - obj.min)
else
( local bbmin = obj.min
local bbmax = obj.max
local bbSize = (obj.max - obj.min)
for i = 1 to 3 do
( if bbmin[i] < bbox.minv[i] do bbox.minv[i] = bbmin[i]
if bbmax[i] > bbox.maxv[i] do bbox.maxv[i] = bbmax[i]
)
local bbSize = (obj.max - obj.min)
)
)
bbox
)

