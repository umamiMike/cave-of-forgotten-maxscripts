--mySheet =  openFile "C:\Documents and Settings\Mike\Desktop\Maxtest.xls"
--xl = createOLEObject "Excel.Sheet"
--xl.application.visible = true


colCount = 2

for i = 1 to 20 collect ( xl.application.cells 1 i)

--this gets the column names into an array called ColNames
function getColNames = (

global ColNames = #()



for i = 1 to  colCount do
	(
	rowArray = #()

	
	
	colName = xl.application.cells 1 i
	
	
	
	rowArray = for k = 2 to 100  collect xl.application.cells k i
	append colNames rowArray
	)

)

getColNames()


function makeText = (
--myExtrude = Extrude()
for i = 1 to 50 do(
myText = text()
myText.pos = [random 0 3000,random 0 3000,random 0 3000]
myText.text = colnames[random 1 colCount][random 2 48].value as string
myText.size = random 80 120
myText.name = myText.text





)
--addmodifier myText (myExtrude)
)


makeText()

