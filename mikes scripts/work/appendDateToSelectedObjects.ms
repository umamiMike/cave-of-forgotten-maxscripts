--mydate
--functions----------------
fn getDate = (
	x = filterstring localtime " "
	mydate = x[1]
	)

fn appendDate myObj = (myObj.name = myObj.name +"_" + mydate)


fn makeCustomAtt myObj = (



)

--program

getDate()

for i = 1 to selection.count do (
myObj = selection[i]
--appendDate(myObj)
)

