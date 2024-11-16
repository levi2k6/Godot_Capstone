extends Panel
@onready var drawer = $"../../drawer"
@onready var label = $Label


func show_description():
	if drawer.current_game == "game1":
		label.text = "Soda Tiles is an interactive game designed to enhance and measure a child’s cognitive memory skills through engaging sequencing challenges. It encourages children to remember and arrange items in the correct order by visually remembering the pattern, fostering focus and memory retention in a playful environment.";
	elif drawer.current_game == "game2":
		label.text = "Digit Hack is a memory game designed to test and enhance a child’s number recall skills, focusing specifically on numerical memory. It challenges children to remember and reproduce sequences of numbers, strengthening their cognitive retention and focus with numbers.";
	elif drawer.current_game == "game3":
		label.text = "Meteor Rush is a fast-paced reaction game that tests and improves a child’s response speed through exciting gameplay. By challenging players to react quickly to falling meteors, the game sharpens their reflexes and promotes quicker decision-making skills in a fun, interactive setting.";

