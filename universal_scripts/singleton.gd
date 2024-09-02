extends Control
var database = SQLite.new()
var user_path = "user://data.db"
var state = "close"

func _ready():
	print("singleton")
	create_table()
	pass


func create_table():
	
	if !FileAccess.file_exists(user_path):
		database.path = user_path
		database.open_db()
		print(database.path)
		
		database.query('
		CREATE TABLE "child" (
		"id" INTEGER NOT NULL,
		"fname" TEXT,
		"lname" INTEGER,
		PRIMARY KEY("id" AUTOINCREMENT)
		);
		
		CREATE TABLE "collection" (
		"child_id" INTEGER,
		"item_id" INTEGER,
		FOREIGN KEY("child_id") REFERENCES "child"("id")
		);
		
		CREATE TABLE "datas" (
		"id" INTEGER,
		"money" INTEGER,
		FOREIGN KEY("id") REFERENCES "child"("id")
		);
		
		CREATE TABLE "date" (
		"today" INTEGER
		);
		
		CREATE TABLE "items" (
		"id" INTEGER,
		"name" TEXT,
		"type" TEXT,
		PRIMARY KEY("id" AUTOINCREMENT)
		);
		
		INSERT INTO "items" ( name, type)
		VALUES
		("body1", "body"),
		("body2", "body"),
		("body3", "body"),
		("body4", "body"),
		("body5", "body"),
		("body6", "body"),
		("body7", "body"),
		("body8", "body"),
		("body9", "body"),
		("body10", "body"),
		("eyes1", "eye"),
		("eyes2", "eye"),
		("eyes3", "eye"),
		("eyes4", "eye"),
		("eyes5", "eye"),
		("eyes6", "eye"),
		("eyes7", "eye"),
		("eyes8", "eye"),
		("eyes9", "eye"),
		("eyes10", "eye"),
		("mouth1", "mouth"),
		("mouth2", "mouth"),
		("mouth3", "mouth"),
		("mouth4", "mouth"),
		("mouth5", "mouth"),
		("mouth6", "mouth"),
		("mouth7", "mouth"),
		("mouth8", "mouth"),
		("mouth9", "mouth"),
		("mouth10", "mouth"),
		("hat1", "hat"),
		("hat2", "hat"),
		("hat3", "hat"),
		("hat4", "hat"),
		("hat5", "hat"),
		("hat6", "hat"),
		("hat7", "hat"),
		("hat8", "hat"),
		("hat9", "hat"),
		("hat10", "hat"),
		("fc250c", "color"),
		("69f055", "color"),
		("4688f9", "color"),
		("ffd02e", "color"),
		("f0700a", "color"),
		("7145f0", "color"),
		("fb67d0", "color"),
		("93462e", "color"),
		("8d295c", "color"),
		("5ef3ea", "color"); 
		
		
		CREATE TABLE "pet" (
		"id" INTEGER,
		"name" TEXT,
		"hunger" INTEGER,
		"body_id" INTEGER,
		"eyes_id" INTEGER,
		"mouth_id" INTEGER,
		"hat_id" INTEGER,
		"color_id" INTEGER,
		FOREIGN KEY("id") REFERENCES "child"("id")
		);
		')
		state = "open"
		print("QUERY SUCCESS")
		
	else:
		database.path = user_path
		database.open_db()
		print("DATABASE ALREADY EXIST")
	
	pass






