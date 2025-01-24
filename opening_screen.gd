extends Node2D



func _on_button_pressed():
	var camera = get_node("Camera2D")
	camera.set_position(Vector2(100, 100))
	var new_scene = load("res://CardSelect.tscn")
	get_tree().change_scene(new_scene)
