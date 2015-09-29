
fn makeCameraMap obj

theCap = "select a bitmap for " + i.name
thisMap = selectBitmap caption:theCap


theMat = vrayMtl name:theObj.name
theMat.texmap_diffuse = Camera_Map_Per_Pixel ()