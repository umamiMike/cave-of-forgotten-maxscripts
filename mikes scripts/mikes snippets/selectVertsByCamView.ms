fn isPointInFrustrum pointPos = (
thePos = pointPos * viewport.getTM()
screen_origin = mapScreenToView [0,0] (thePos.z) [renderWidth,renderHeight]
end_screen = mapScreenToView [renderWidth,renderHeight] thePos.z [renderWidth,renderHeight]
world_size = screen_origin-end_screen
x_aspect = renderWidth/(abs world_size.x)
y_aspect = renderHeight/(abs world_size.y)
screen_coords = point2 (x_aspect*(thePos.x-screen_origin.x)) (-(y_aspect*(thePos.y-screen_origin.y)))
(((screen_coords.x >= 0) AND (screen_coords.x < renderWidth)) AND ((screen_coords.y >= 0) AND (screen_coords.y < renderHeight)))
)


--Select the vertices on the currently selected editable mesh which are within the current Perspective viewport's view frustrum:

$.selectedVerts = for i = 1 to $.numVerts collect (
if (isPointInFrustrum (polyOp.getVert $ i)) then ( i ) else ( dontcollect )
)

