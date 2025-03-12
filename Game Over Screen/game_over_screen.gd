extends Node2D

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://dungeon.tscn")


func _on_title_pressed() -> void:
	get_tree().change_scene_to_file("res://Title Screen/title_screen.tscn")
