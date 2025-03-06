extends Node2D

func _on_switch_a_2d_body_entered(body: Node2D) -> void:
	DungeonSignals.DeleteStatues.emit()
