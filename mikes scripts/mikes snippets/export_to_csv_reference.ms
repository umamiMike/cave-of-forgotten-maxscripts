  -------------------------------------------
  -- ExportAsCVS.ms
  --  exports the currently selected models
  --  height, width, length (in that order)
  --
  --  Version: 0.1
  --  Tested using 3ds max v8.0
  --
  -------------------------------------------
  
  global theFileStream
  
  -------------------------------------------
  -- START
  -------------------------------------------
  
  fn exportAs fileName = (
  	-- create file
  	theFileStream = createFile fileName;
  
  	if theFileStream != undefined then (
  		-- file ok to write
  		selection = getCurrentSelection()
  
  		if selection.count > 0 then (
  			-- write header
  			printToFile ("x, y, z, Pieces, Name")
  			-- write data
  			for obj in selection do (
  				 _name = obj.name
  				 _height = floorToNDecimals(obj.height) as string
  				 _width  = floorToNDecimals(obj.width)  as string
  				 _length = floorToNDecimals(obj.length) as string
 				 -- assuming pieces is always 1
 				 _pieces = "1"
  				 -- write to file
  				 printToFile (_length+","+_width+","+_height+","+_pieces+","+_name)
  			)
  		) else (
  			-- error
  			printToFile ("Error: Nothing Selected!")
  		)
  	)
  
  	-- close
  	close theFileStream;
  )
  
  fn printToFile theString t:0 = (
  	-- auto tab (empty string)
  	tabString = "												   ";
  	tabString = substring tabString 1 (t*4);
  	-- print
  	format "%%\n" tabString theString to:theFileStream;
  )
  
  fn floorToNDecimals theNumber N:2 = (
  	return floor( ((pow 10 N) * theNumber) ) / (pow 10 N)
  )
  
  -------------------------------------------
  -- RUN
  -------------------------------------------
  
  exportAs("Test2.csv");
  
  -------------------------------------------
  -- END
  -------------------------------------------
