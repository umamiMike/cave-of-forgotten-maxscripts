myarray = selection as array
global ranArray = #()


--run through the selection count and append a random number

for i = 1 to myarray.count do
		(
		l = random 1 myarray.count
		if l != ranArray[i] do
		(
		append ranArray l
		)
		print ranArray[i]
		)
	
fn moveTheKeys = (
for i = 1 to myarray.count do
		(
		
		movekeys myarray [rannum] (2*i)
		)
)

for i = 1 ranArray.count do

(


)

moveTheKeys()

-- make an array of the output of rannum called ranArray
-- if rannum does NOT equal any value of an item in ranArray then movekeys
-- else skip dat shit.
-- select a random object from selection

--ranArray should contain a list of random nonrepeating numbers between 
--1 and the number of objects in the array
-- scan through the already generated results 
--of ranArray and compare the current value of L to those numbers.
--if L = any output from ranArray, don't use that 

