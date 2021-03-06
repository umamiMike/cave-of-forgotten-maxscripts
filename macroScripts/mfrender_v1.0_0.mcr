/* 
Script for rendering multiple files easy
made by Jos Balcaen 

version 1.0

how to use :
select the files you want to render. the files have to be ready! 
including : output path, size, renderer, ... complete render setup.
this script just push the render button
*/

macroScript render_for_spano
category:"umami"
tooltip:"Render multiple files"
buttontext:"MFRender"
(
	rollout myRoll "Render multiple files"
	(
			local number_of_files = 0
			local ListOfMaxFiles = #()
			
			button btnBrowseFile "Browse for files" width: 370
			multilistbox mlbMaxFiles
			label lbNumberOfFiles " No files selected"
			button btnRender "Render all files" width: 370 height:30
			
			on btnBrowseFile pressed do
			(
				/*	
				--path = (getSavePath caption:"Select Save File directory")
					path = getMAXOpenFileName()
				if path != undefined then
				(
					append ListOfMaxFiles path
					mlbMaxFiles.items = ListOfMaxFiles
					number_of_files = mlbMaxFiles.items.count
					lbNumberOfFiles.text = number_of_files as string + " files selected"
				)*/
				
				--NEW CODE
				/*****************************************/
				theDialog = dotNetObject "System.Windows.Forms.OpenFileDialog" --create a OpenFileDialog 
				theDialog.title = "PLEASE Select One Or More Files" --set the title
				theDialog.Multiselect = true --allow multiple files to be selected
				theDialog.Filter = "MAX Files (*.max)|*.max|All Files (*.*)|*.*" --specify the filter
				theDialog.FilterIndex = 1 --set the filter drop-down list to All Files
				result = theDialog.showDialog() --display the dialog, get result into variable
				result.ToString() --when closed, convert the result to string
				result.Equals result.OK --returns TRUE if OK was pressed, FALSE otherwise
				result.Equals result.Cancel --returns TRUE if Cancel was pressed, FALSE otherwise
				join ListOfMaxFiles theDialog.fileNames --the selected filenames will be returned as an array
				mlbMaxFiles.items = ListOfMaxFiles
				number_of_files = mlbMaxFiles.items.count
				lbNumberOfFiles.text = number_of_files as string + " files selected"
				/*****************************************/
			)
				
			on btnRender pressed do
			(
				starttime = timeStamp()
				--NEW CODE
				/*****************************************/
				theTimer = dotNetObject "System.Windows.Forms.Timer" --create a Timer
				fn printTime = (print localTime) --define a MAXScript function to be called by the Timer.
				dotnet.addEventHandler theTimer "tick" printTime --add ON TICK event hander to call the function
				theTimer.interval = 1000 --set the tick interval to 1 second (1000 milliseconds)
				theTimer.start() --start the Timer
				timerstringstart = printTime() --NEW CODE
				--theTimer.stop() --use this method to stop the Timer.
				/*****************************************/
				for i = 1 to (mlbMaxFiles.items.count) do
				(
					loadMaxFile (mlbMaxFiles.items[i] as string) quiet:true
					actionMan.executeAction 0 "50031"  -- Render: Render
				)
				theTimer.stop()--NEW CODE
				printTime() --NEW CODE
				timerstringend = printTime() --NEW CODE
				total_time = theTimer.interval as string
				endtime = timeStamp()
				tijdsinterval = ((endtime - starttime) / 1000.0)
				tijdinuur = ((endtime - starttime) / 1000.0)/3600
				--messagebox("succeeded, het renderen duurde \n" +  tijdsinterval as string + " seconden \n" + tijdinuur as string+ " uur" )
				messagebox("succeeded, \n" + "start time : " + timerstringstart + "\n end time : " + timerstringend)-- + "\n total time : " + total_time)
			)
			
			
				groupbox boxinfo "Info" height: 150 width:370
			label lblinfo "Important : \n each file must be ready to render. (complete render setup) \n beware of fileoverriding!" height:100 width: 300 pos:[25,240]
			label jos "Made by jos_balcaen@hotmail.com" pos:[250,370]
			
			
	)
	
		createdialog myRoll width:400 height:390
		
		
) 