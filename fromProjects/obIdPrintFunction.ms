
function printGbuffs = (
	buffArray = #()
for o in objects do (
	
	if o.gbufferchannel > 0 do(
		append buffArray o
		)
)
--sort buffArray
for i in buffArray do (
	theText = i.name +":  gbufID =  " +  i.gbufferchannel as string
	print (theText)
)

) -- end function