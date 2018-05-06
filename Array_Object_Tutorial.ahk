; ### AUTOHOTKEY ARRAY/OBJECT/CLASS TUTORIAL ###
;
; ### ARRAYS ###
; # An array is basically like a list.
; # This means that if you want to make a list like this:
;
; # LIST
; # 1. Bananas
; # 2. Butter
; # 3. Cream
; # 4. Sugar
;
; # This would be represented in an array like this:

List := ["Bananas", "Butter", "Cream", "Sugar"]

; # So to define an array, you use the [] symbols.

; ### HOW TO RETRIEVE ITEMS FROM THE ARRAY ###
; # So, how can we retrieve a specific item from the list?
; # Like this!

Msgbox % List[1] ; 									<--- Retrieves the first (number 1) item in the array, "Bananas". "List" is the array, and [1] is the list item number

; # or like this:

Msgbox % List.1										<--- Retrieves the first (number 1) item in the array, "Bananas". "List" is the array, and 1 is the list item number (after the ".")

; # Using this knowledge, we can recreate the list like this:

ListVar := "LIST`r`n" ; 							<--- Sets the variable as a string that says LIST and then a new row
Loop % List.Maxindex() ; 							<--- Here we use "Maxindex()", which is a method to find the number of (possible) values in the array. More about methods later!
	ListVar .= A_Index ". " List[A_Index] "`r`n" ; 	<--- Concatenates (adds) the A_Index (variable for loop iteration) and then the list item
Msgbox % ListVar ; 									<--- Shows us our original list!

; # You can also do this as a "for-loop" if you don't want to use methods just yet (end result is exactly the same as above):

ListVar := "LIST`r`n" ; 							<--- Sets the variable as a string that says LIST and then a new row
For item, value in List ;							<--- Goes through the array/list in order,
	ListVar .= item ". " value "`r`n" ; 			<--- Where item (defined above) specifies the item number (for example: "1") and value (also defined above) shows us the value (for example "Bananas")
Msgbox % ListVar ; 									<--- Shows us our original list!

; ### HOW TO MODIFY AN ARRAY ###
; # When an array has been defined, you may still want to add values to it.
; # You can do this in different ways:

List.Push("New") 									<--- "Pushes" the word "New" to the last position of the array

; # or:

List.InsertAt(3, "Three")							<--- "Inserts" the word "Three" at position 3 in the array. Word formerly at position 3 is now at positon 4

; # And as always, if you can add a value you can also remove it like in the following examples:

List.Pop() ; 										<--- "Pops", or removes, the last value of the array (which was the word "New")

; # or:

List.RemoveAt(3) ;									<--- Removes the entry at position 3 in the array. Word formerly at position 4 is now at position 3

; ### OBJECTS ###
; # When you write an object in AutoHotkey, you use the {} symbols to enclose the object.
; # An object in AutoHotkey is used when you might want to describe a property of an item in a list:

List := {2: "Bananas", 1: "Butter", 3: "Cream", 4: "Sugar"}

; # In the list above, we have described that for example, item number 3 is "Cream", just like in the array example. Let's recreate the list again!

ListVar := "LIST`r`n" ; 							<--- Sets the variable as a string that says LIST and then a new row
Loop % List.Maxindex() ; 							<--- Here we use "Maxindex()", which is a method to find the number of (possible) values in the array. More about methods later!
	ListVar .= A_Index ". " List[A_Index] "`r`n" ; 	<--- Concatenates (adds) the A_Index (variable for loop iteration) and then the list item
Msgbox % ListVar ; 									<--- Shows us our original list!

; # Did you spot the difference?
; # That's right, in this object, we defined item number 2 as "Bananas" even though it's clearly written before "Butter".
; # This is because in an object. In objects, items are always sorted and properties belong to each item.
; # This also means that "Bananas" is now the property of item 2.
; # While this is still technically a list, object-items can be defined as other stuff. 
; # Let's make a new object, based on a cat:

Cat := {"Claws": "Nasty", "Legs": 4, "Tail": {"Count": 1, "Description": "Beautiful"}}

; # The same object can also be written as a multi-line object for readability, starting new lines with ",":

Cat := {"Claws": "Nasty"
, "Legs": 4
, "Tail": {"Count": 1, "Description": "Beautiful"}}

; ### HOW TO RETRIEVE ITEMS FROM THE OBJECT ###
; # We can still use the same method to retrieve items from an object as we did in an array:

Msgbox % Cat["Claws"]

; # or:

Msgbox % Cat.Claws

; # So let's see what happens if we try to assemble our cat-object like we did with the array:

CatVar := "CAT`r`n" ; 								<--- Sets the variable as a string that says CAT and then a new row
For item, value in Cat ;							<--- Goes through the object in sorted order,
	CatVar .= item ": " value "`r`n" ; 				<--- Where item (defined above) specifies the item number (for example: "Claws") and value (also defined above) shows us the value (for example "Nasty")
Msgbox % CatVar ; 									<--- Shows us our cat-object!

; # The claws are there, and the legs are there, but what happened to the tail?
; # Since the tail is an object in itself with it's own properties within the cat-object, we can't retrieve it this way.
; # If you try to use an object without specifying a property in AutoHotkey, it shows up empty instead.
; # That does mean we can use a little workaround though:

CatVar := "CAT`r`n" ; 								<--- Sets the variable as a string that says CAT and then a new row
For item, value in Cat ;							<--- Start looking through the Cat-object for properties...
{
	if value is space ;								<--- If the value is empty, like in this case...
		for item2, value2 in Cat[item]	;			<--- Check if the item that contained the empty value contains more items!
			CatVar .= item " - " item2 ": " value2 "`r`n" ;	<--- Add those to the Cat-object string-variable
	else ;											<--- If the item is not empty (or does not contain an object)...
		CatVar .= item ": " value "`r`n" ;			<--- Add them normally to the Cat-object string-variable
}
Msgbox % CatVar