extends Node2D


func _ready():
	%"Battle Music".play()
	

func _on_player_hand_delete() -> void:
	queue_free()
	get_tree().paused = false
