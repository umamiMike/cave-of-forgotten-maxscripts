trackCam = $
myTrackView = batchRenderMgr.CreateView trackCam
		batchRenderMgr.displayRenderedViews
		myFilePath = getFilenamePath myTrackView.outputFilename
