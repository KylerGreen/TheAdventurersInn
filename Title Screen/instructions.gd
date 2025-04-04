extends Node2D

func _ready():
	%"Menu Music".play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://dungeon.tscn")
