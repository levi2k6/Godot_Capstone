extends Panel
@onready var child_settings = $"../..";
@onready var options_modal = $"../OptionsModal";
@onready var h_box_container = $"../Panel/HBoxContainer";

var child_id;

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_yes_button_up():
	Singleton.database.query("DELETE FROM sequence_session WHERE id IN (SELECT session_id FROM sequence_junction_session WHERE game_id = %s)"%child_id);
	Singleton.database.query("DELETE FROM number_memory_session WHERE id IN (SELECT session_id FROM number_memory_junction_session WHERE game_id = %s)"%child_id);
	Singleton.database.query("DELETE FROM timing_session WHERE id IN (SELECT session_id FROM timing_junction_session WHERE game_id = %s)"%child_id);
	
	Singleton.database.query("DELETE FROM sequence_junction_session WHERE game_id = %s"%child_id);
	Singleton.database.query("DELETE FROM number_memory_junction_session WHERE game_id = %s"%child_id);
	Singleton.database.query("DELETE FROM timing_junction_session WHERE game_id = %s"%child_id);
	
	Singleton.database.query("DELETE FROM sequence_game WHERE id = %s"%child_id);
	Singleton.database.query("DELETE FROM number_memory_game WHERE id = %s"%child_id);
	Singleton.database.query("DELETE FROM timing_game WHERE id = %s"%child_id);
	
	Singleton.database.query("DELETE FROM collection WHERE child_id = %s"%child_id);
	Singleton.database.query("DELETE FROM datas WHERE id = %s"%child_id);
	Singleton.database.query("DELETE FROM milestone WHERE id = %s"%child_id);
	Singleton.database.query("DELETE FROM pet WHERE id = %s"%child_id);
	Singleton.database.query("DELETE FROM status WHERE id = %s"%child_id);
	Singleton.database.query("DELETE FROM datas WHERE id = %s"%child_id);
	
	Singleton.database.query("DELETE FROM child WHERE id = %s"%child_id);
	h_box_container.size.y -= 120;
	options_modal.visible = false;
	visible = false;
	child_settings.populate_child_panels();
	pass # Replace with function body.

#func delete_game_session():
	#DELETE FROM timing_session WHERE id IN (SELECT timing_id FROM game_timing WHERE game_id = 1);



func _on_no_button_down():
	options_modal.visible = false;
	visible = false;
	pass # Replace with function body.
