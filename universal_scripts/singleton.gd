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
		("eyes1", "eye"),
		("eyes2", "eye"),
		("eyes3", "eye"),
		("mouth1", "mouth"),
		("mouth2", "mouth"),
		("hat1", "hat"),
		("hat2", "hat"); 
		
		
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






