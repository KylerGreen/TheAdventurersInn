extends Node2D

signal mouse_entered
signal mouse_exited



func _on_card_mouse_entered() -> void:
	mouse_entered.emit()

func _on_card_mouse_exited() -> void:
	mouse_exited.emit()
