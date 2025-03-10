extends Node2D

var only_once : bool = true

func _ready() -> void:
	DungeonSignals.only_once.connect(one_time)
	
func _on_switch_2a_2d_body_entered(body: Node2D) -> void:
	if only_once:
		%Doorway.queue_free()
		%Switch2A2D.queue_free()
		%Switch.queue_free()
		%Switch2.set_visible(true)
		only_once = false
		DungeonSignals.only_once2.emit()
		DungeonSignals.DisplayText.emit('You found the hidden switch!')

func one_time():
	only_once = false
