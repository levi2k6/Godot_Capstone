extends Node
var database = SQLite.new()
var user_path = "user://data.db"
var state = "close"

func _ready():
	print("singleton")
	create_table()
	pass


func create_table():
	
	if !FileAccess.file_exists(user_path):
		database.path = user_path;
		database.open_db();
		state = "open";
		print(database.path);
		
		database.query('
		CREATE TABLE "child" (
		"id" INTEGER NOT NULL,
		"fname" TEXT,
		"lname" INTEGER,
		"pet_id" INTEGER UNIQUE,
		"datas_id" INTEGER UNIQUE,
		PRIMARY KEY("id" AUTOINCREMENT)
		);

		CREATE TABLE "pet" (
		"id" INTEGER NOT NULL,
		"name" TEXT,
		"hunger" INTEGER,
		"body_id" INTEGER,
		"eyes_id" INTEGER,
		"mouth_id" INTEGER,
		"hat_id" INTEGER,
		"color_id" INTEGER,
		PRIMARY KEY("id"),
		FOREIGN KEY("id") REFERENCES "child"("pet_id")
		);

		CREATE TABLE "datas" (
		"id" INTEGER NOT NULL,
		"money" INTEGER,
		"sequence_game_id" INTEGER UNIQUE,
		"number_memory_game_id" INTEGER UNIQUE,
		"timing_game_id" INTEGER UNIQUE,
		"milestone_id" INTEGER UNIQUE,
		PRIMARY KEY("id"),
		FOREIGN KEY("id") REFERENCES "child"("datas_id")
		);

		CREATE TABLE "milestone"(
		"id" INTEGER NOT NULL,
		"total_time" INTEGER,
		"total_collection" INTEGER,
		"total_pet_fully_fed" INTEGER,
		"total_games_played" INTEGER,
		"total_days_played" INTEGER,
		"total_money_earned" INTEGER,
		PRIMARY KEY("id"),
		FOREIGN KEY("id") REFERENCES "datas"("milestone_id")
		);

		CREATE TABLE "sequence_game"(
		"id" INTEGER NOT NULL,
		"total_session" INTERGER,
		"highest_level" INTERGER,
		PRIMARY KEY("id"),
		FOREIGN KEY("id") REFERENCES "datas"("sequence_game_id")
		);

		CREATE TABLE "number_memory_game"(
		"id" INTEGER NOT NULL,
		"total_session" INTERGER,
		"highest_level" INTERGER,
		PRIMARY KEY("id"),
		FOREIGN KEY("id") REFERENCES "datas"("number_memory_game_id")
		);

		CREATE TABLE "timing_game"(
		"id" INTEGER NOT NULL,
		"total_session" INTEGER,
		"highest_level" INTEGER,
		PRIMARY KEY("id"),
		FOREIGN KEY("id") REFERENCES "datas"("timing_game_id")
		);

		CREATE TABLE "sequence_session"(
		"id" INTEGER NOT NULL,
		"level_reached" INTEGER,
		"difficulty" TEXT,
		PRIMARY KEY("id" AUTOINCREMENT)
		);

		CREATE TABLE "number_memory_session"(
		"id" INTEGER NOT NULL,
		"level_reached" INTEGER,
		"difficulty" TEXT,
		PRIMARY KEY("id" AUTOINCREMENT)
		);

		CREATE TABLE "timing_session"(
		"id" INTEGER NOT NULL,
		"level_reached" INTEGER,
		"difficulty" TEXT,
		PRIMARY KEY("id" AUTOINCREMENT)
		);

		CREATE TABLE "sequence_junction_session"(
		"game_id" INTEGER,
		"session_id" INTEGER UNIQUE,
		FOREIGN KEY("game_id") REFERENCES "sequence_game"("id"),
		FOREIGN KEY("session_id") REFERENCES "sequence_session"("id")
		);

		CREATE TABLE "number_memory_junction_session"(
		"game_id" INTEGER ,
		"session_id" INTEGER UNIQUE,
		FOREIGN KEY("game_id") REFERENCES "number_memory_game"("id"),
		FOREIGN KEY("session_id") REFERENCES "number_memory_session"("id")
		);

		CREATE TABLE "timing_junction_session"(
		"game_id" INTEGER,
		"session_id" INTEGER UNIQUE,
		FOREIGN KEY("game_id") REFERENCES "timing_game"("id"),
		FOREIGN KEY("session_id") REFERENCES "timing_session"("id")
		);

		CREATE TABLE "date" (
		"today" INTEGER
		);

		CREATE TABLE "status" (
		"redeem_status" BOOLEAN,
		"fully_fed_status" BOOLEAN
		);

		CREATE TABLE "collection"(
		"child_id" INTEGER,
		"item_id" INTEGER,
		FOREIGN KEY("child_id") REFERENCES "child"("id"),
		FOREIGN KEY("item_id") REFERENCES "items"("id")
		);

		CREATE TABLE "items" (
		"id" INTEGER,
		"name" TEXT,
		"type" TEXT,
		PRIMARY KEY("id" AUTOINCREMENT)
		);

		INSERT INTO "items"(name, type)
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
		')
		print("QUERY SUCCESS");
	else:
		database.path = user_path
		database.open_db()
		state = "open"
		print("DATABASE ALREADY EXIST")
	
	pass

func _exit_tree():
	if state == "open":
		database.close_db();

