extends Node2D

var datas = [
	{"name": "marco", "id": 1},
	{"name": "john", "id": 2},
	{"name": "dow", "id": 3},
	{"name": "damian", "id": 4},
	{"name": "majiki", "id": 5},
	]

var lib = [
	{"name": "", "id": 0},
	{"name": "", "id": 0},
	{"name": "", "id": 0},
	{"name": "", "id": 0},
	{"name": "", "id": 0},
	]

func _ready():
	
	for l in lib:
		var n = 0
		l.id = datas[n].id
		l.name = datas[n].name
		print(lib[n])
		++n
	print(lib)
	



func _test():
	pass








func _on_button_pressed():
	print("grow")
	
