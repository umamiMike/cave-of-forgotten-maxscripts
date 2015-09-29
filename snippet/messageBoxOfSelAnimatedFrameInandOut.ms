try(
inFrame = $.mat.diffusemap.starttime
myBmInfo = getBitmapInfo $.mat.diffusemap.bitmap
outFrame = inFrame + myBmInfo[11]
messageBox(inFrame as string + "   " + outFrame as string)
)
catch()
