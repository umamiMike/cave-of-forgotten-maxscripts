fn getGbufsOfScene = (--returns an array of object ids in scene, good for figuring out what ob id numbers are currently being used
gbufArr = #()
for i in objects where i.gbufferchannel != 0 do(
	
	appendIfUnique gbufArr i.gbufferchannel
)

sort gbufArr
return gbufArr

)

fn getGbufsOfSel = (--returns an array of object ids in scene, good for figuring out what ob id numbers are currently being used
gbufArr = #()
for i in selection where i.gbufferchannel != 0 do(
	
	appendIfUnique gbufArr i.gbufferchannel
)
)

fn collectObIds = (
	
	rawArray = for i in objects where i.gbufferchannel != 0  collect i
		
		
	)
	
	fn collectObIdsSel = (
	
	rawArray = for i in selection where i.gbufferchannel != 0  collect i
		
		
	)


fn printObIds arr =  (
	qsort arr obIdSort
	for o in arr do (
		print ("Ob ID = "  + o.gbufferchannel as string + "\t"  + o.name )
	)
	
)		
fn obIdSort a b = (
	
	case of
	(
		
	(a.gbufferchannel > b.gbufferchannel):  1
	(a.gbufferchannel < b.gbufferchannel): -1
	default: 0
	
	
	)--end case
	
)--end fn

--program flow fns

fn printOnlySelIds = (
	b = collectObIdsSel()
	printObIds b
	
)

fn printAllIds = (
	b = collectObIds()
	printObIds b
	
)