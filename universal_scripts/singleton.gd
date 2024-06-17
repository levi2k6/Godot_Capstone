extends Node
var database : SQLite
#const GAME_MENU = preload("res://scenes/game_menu/Game_Menu.tscn")



func _ready():
	database = SQLite.new()
	database.path = "res://data.db"
	database.open_db()
	
	
