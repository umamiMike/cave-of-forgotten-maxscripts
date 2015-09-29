function getContFromTrackView = (
fTv=trackViews.getTrackView 1
numSelInFrom=fTv.numSelTracks()
fTv.getSelected 1
)


myScript = float_script()

myCont = getContFromTrackView()

--globIndex = ftv.getIndex myCont

--trackToAssign = fTv.selectTrackByIndex globIndex true
ftv.assignController myScript
--myCont = myScript


--fTv2.selectTrackByIndex theIndex[i] true --select the current track only
--fTv2.assignController cons[i] --assign the i-th controller from source to target TV