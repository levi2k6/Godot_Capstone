extends VBoxContainer
@onready var all_count = $AllCount
@onready var normal_count = $NormalCount
@onready var hard_count = $HardCount


func set_text(text_count, difficulty):
	if difficulty == "all":
		all_count.text = str(text_count);
	elif difficulty == "normal":
		normal_count.text = str(text_count);
	elif difficulty == "hard":
		hard_count.text = str(text_count);
