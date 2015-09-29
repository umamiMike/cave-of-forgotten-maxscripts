undo on

(
myarray = selection as array


--for i = 1 to objects.count do( if classof objects[i] != Skylight then hide objects[i])
for i = 1 to myarray.count do(hide myarray[i])

for i = 1 to myarray.count do


(

myobj = myarray[i]
unhide myobj doLayer:false
myname = myobj.name +"_"+ myobj.gbufferchannel as string
sceneStateMgr.CaptureAllParts myname
mycam = $camera01
mytrackview = batchRenderMgr.CreateView mycam

mytrackview.name = myname

myfilename = mytrackview.outputfilename
mytype = getfilenametype myfilename
mypath = getfilenamepath myfilename
mytrackview.outputfilename = mypath + myname + "_"+ mytype
mytrackview.presetFile = myname
batchRenderMgr.displayRenderedViews

hide myobj

)

)