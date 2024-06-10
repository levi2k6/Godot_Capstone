extends Node


var numbers = [
	1,4,6,8
]

var items = {
	1:  {"texture": preload("res://sprite/body/body1.png"), "name":	"", "type": ""},
	2:  {"texture":preload("res://sprite/body/body2.png"), "name": "", "type": ""},
	3:  {"texture":preload("res://sprite/body/body3.png"), "name": "", "type": ""},
	4:  {"texture":preload("res://sprite/face/eyes/eye1-Sheet.png"), "name": "", "type": "" },
	5:  {"texture":preload("res://sprite/face/eyes/eyes2-Sheet.png"), "name": "", "type": ""  },
	6:  {"texture":preload("res://sprite/face/eyes/eyes3-Sheet.png"), "name": "", "type": "" },
	7:  {"texture":preload("res://sprite/face/mouth/mouth1-Sheet.png"), "name": "", "type": "" },
	8:  {"texture":preload("res://sprite/face/mouth/mouth2-Sheet.png"), "name": "", "type": "" },
	9:  {"texture":preload("res://sprite/hat/hat1.png"), "name": "", "type": "" },
	10: {"texture":preload("res://sprite/hat/hat2.png"), "name": "", "type": "" }
	}


var my_collection = []


func _ready():  
	Singleton.database.query(
		"SELECT * FROM parts;"
	)
	
	for i in Singleton.database.query_result:
		items[i.id].name = i.name
		items[i.id].type = i.type
		#print(items[i.id])
	
	
	for item in items:
		for number in numbers:
			if item == number:
				my_collection.append(items[number])
				
				
				
	#print(my_collection)

