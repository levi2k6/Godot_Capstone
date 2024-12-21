extends Label

func _ready():
	var child = DataManager._get_current_child();
	if child.size() == 0:
		return;
	var child_data = child[0];
	text = "%s %s" %[child_data.fname, child_data.lname];
