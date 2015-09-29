global gbufferArray = #()
global highgbuff



for i = 1 to selection.count do
(
--print (objects[i].gbufferchannel)
--append gbufferArray objects[i].gbufferchannel
selection[i].gbufferchannel = i
format "name:%, Gbuffer:%\n"  selection[i].name selection[i].gbufferchannel
)
