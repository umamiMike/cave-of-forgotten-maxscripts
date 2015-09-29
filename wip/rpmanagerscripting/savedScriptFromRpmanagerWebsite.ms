/* You can both define, and also edit the current elements.
* 
* The easiest way is to setup the elements via the standard 3dsmax maxcript setup, and then call a synch script that captures the current setup for a specified pass.
* 
* for example, if you had 3 passes in the scene you could do something like this:
*/
/* 
INFO FROM FORUM 
2 ways off the top of my head: 
 
RPMData.setUICheckData 9 "newprefix" 
 
the UI won't update, though if RPM is open you can do 
 
rmpasses.rmshotname.text = "newprefix" 
 
to set the UI, or if the UI is open you can just do: 
rmpasses.rmshotname.entered "newprefix" 
  */
 


re = maxOps.GetCurRenderElementMgr() -- get the current render element manager
re.removeallrenderelements() -- remove all renderelements

re.addrenderelement (specular elementname:"specular")
re.addrenderelement (diffuse elementname:"diffuse")
-- setup element properties via script here
passnumb = rpmdata.getUniqueFromIndex 1
RPManREll.captureExistingREll 0 passnumb

re.removeallrenderelements() -- remove all renderelements
re.addrenderelement (alpha elementname:"alpha")
-- setup element properties via script here
passnumb = rpmdata.getUniqueFromIndex 2
RPManREll.captureExistingREll 0 passnumb

re.removeallrenderelements() -- remove all renderelements
re.addrenderelement (refraction elementname:"refraction")
-- setup element properties via script here
passnumb = rpmdata.getUniqueFromIndex 3
RPManREll.captureExistingREll 0 passnumb




--Note that the captureexistingrell call *appends* the elements to any currently on the passes, so you might want to clear them out, ie

-- this clears all elements from pass 1
passindex = 1
numelements = RPManREll.getREllCount passindex
for i in 1 to numelements do RPManREll.delREll passindex 1


--This won't refresh the UI, so update a pass to see the change.


--After setup, you can edit the paths etc without a full rebuild (unless you want to) via
/* 
numb = RPMdata.getUniqueFromIndex 1
reStorage = execute ("TrackViewNodes.RenderPassManager.Rendermanager_RElement.REset_" +  numb as string + ".REObjStore")
rePath = execute ("TrackViewNodes.RenderPassManager.Rendermanager_RElement.REset_" +  numb as string + ".REObjPath")
reIO = execute ("TrackViewNodes.RenderPassManager.Rendermanager_RElement.REset_" +  numb as string + ".REObjIO")


reStorage is an array of elements, rePath and reIO are arrays of the output data for each element in reStorage.  */