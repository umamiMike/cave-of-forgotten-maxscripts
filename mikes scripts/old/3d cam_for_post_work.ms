-- rotate around object maker
--used to make an image sequence matrix for post reconstruction
--of 3d object


--the sphere the cam will be positioned at on all its verts
global camsphere = sphere()
camsphere.segs = 8
camsphere.radius = 100
convertTo camsphere PolyMeshObject
camsphere.pos = $.pos

mycam = Targetcamera target:(targetObject pos:[20,20,20])
mycam.target.pos = $.pos

for i = 1 to camsphere.verts.count do
(
animate on
(
at time i mycam.pos = camsphere.verts[i].pos
)

)