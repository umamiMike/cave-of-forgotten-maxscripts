macroScript makeVrayMattesForAllObjectIDs
	category:"Umami"
	toolTip:"make vray mattes v1"

(
fn makeMultiMatte Index = (
	
re = maxOps.GetCurRenderElementMgr()
re.removeallrenderelements() -- remove all renderelements 

 --does the actual adding of the render element to the mgr
 
re.AddRenderElement (multimatteelement elementname:("VraymultiMatte"+ ( Index/3) as string) R_gbufIDOn:true R_gbufID:Index G_gbufIDOn:true G_gbufID:(Index + 1) B_gbufIDOn:true B_gbufID:(Index + 2))

	allPassCount = rpmdata.getpasscount()
	
for i = 1 to allPassCount do(
	
passnumb = rpmdata.getUniqueFromIndex i
RPManREll.captureExistingREll 0 passnumb 

)
	
-- showproperties theElement
--   .enabled : boolean
--   .filterOn : boolean
--   .atmosphereOn : boolean
--   .shadowOn : boolean
--   .elementName : string
--   .bitmap : bitmap
--   .vrayVFB : boolean
--   .R_gbufIDOn (GBuf_ON) : boolean
--   .R_gbufID (GBuf_ID) : integer
--   .G_gbufIDOn (GBuf_ON) : boolean
--   .G_gbufID (GBuf_ID) : integer
--   .B_gbufIDOn (GBuf_ON) : boolean
--   .B_gbufID (GBuf_ID) : integer
--   .MatID (isMATID) : boolean
--   .affect_matte_objects : boolean

	
--return passnumb
	
)

fn getGbufsOfScene = (
gbufArr = #()
for i in objects where i.gbufferchannel != 0 do(
	
	appendIfUnique gbufArr i.gbufferchannel
)

sort gbufArr
return gbufArr

)



theGBufs = getGbufsOfScene()
for i = 1 to theGbufs.count do
(
	if mod theGbufs[i] 3 == 1.0 do (
	makeMultiMatte i
		
	)
	
)

) 