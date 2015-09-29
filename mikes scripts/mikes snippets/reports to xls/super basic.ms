myPath = getSavePath caption:"Open em"

out_name = (myPath+"/IdReport.csv")
out_file = createfile out_name


for i = 1 to objects.count do (
nm = objects[i].name
gb = objects[i].gbufferchannel as string
if objects[i].gbufferchannel > 0 then (print (nm+","+gb) to:out_file)

)