extends Node2D


var name_label

func _ready():
	name_label = %Name
	update_text("Punch Good")
	

func update_text(new_text):
	name_label.text = new_text
