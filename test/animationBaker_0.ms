rollout animationBaker "Animation Baker"
(
	
button bakeBtn "BAKE Selected"
spinner rangeSpn "Range:" scale:1 type:#integer range:[0,999999999,0]
label progressLbl "Select something..."
progressbar progress color:red

fn getSelection = (
	try(progressLbl.text = $.name)catch(progressLbl.text = "Select something...")
	)	

on animationBaker open do(
	rangeSpn.value = animationrange.end
	registerRedrawViewsCallback getSelection
	)	

on pickBtn picked sel do(
	pickBtn.caption = pickBtn.object.name as string
	)
	
fn catchFn = (
     slidertime = 0
     for t = 1 to rangeSpn.value do(
	     slidertime = slidertime+1
	     append transforms $.transform
		 progressLbl.text = "Catching animation..."
		 progress.value = 100*t/(rangeSpn.value)
	)
)	

fn bakeFn = (
     animate on(
		 for a=1 to rangeSpn.value do(
	     at time a ($.transform = transforms[a])
		 progressLbl.text = "Creating Keys..."
		 progress.value = 100*a/(rangeSpn.value)
	    )
    )
)	

on bakeBtn pressed do(
	global transforms = #()
     try(	
		 catchFn()
         progress.value = 0
         $.pos.controller = Position_XYZ ()	
         $.rotation.controller = Euler_XYZ ()
         bakeFn()
         progressLbl.text = "DONE"
         progress.value = 0
    )catch(progressLbl.text = "Select something...")	
)

on animationBaker close do(
	unregisterRedrawViewsCallback getSelection
	)
	
)createdialog animationBaker width:120 lenght:200