extends Label

func _ready():
	var child = DataManager._get_child_database()[0];
	text = "%s %s" %[child.fname, child.lname];
