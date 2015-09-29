fn CopyRenderToClipboard =

(

clipboardClass = dotNetClass "System.Windows.Forms.Clipboard" 
b = getLastRenderedImage() 
theFileName = GetDir #image + "\\_renderToClipboard.bmp" 
b.filename = theFileName 
save b 
close b 
theImage = dotNetClass "System.Drawing.Image" 
theBitmap = theImage.FromFile theFileName 
clipboardClass.setImage theBitmap 
theBitmap.Dispose() 
deleteFile theFileName 
clipboardClass.ContainsImage()
)--end fn

 

callbacks.removeScripts id:#CopyRenderToClipboard 

callbacks.addScript #PostRender "CopyRenderToClipboard()" id:#CopyRenderToClipboard 

 
