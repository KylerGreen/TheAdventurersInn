extends Node2D

var only_once : bool = true

func _ready() -> void:
	DungeonSignals.only_once2.connect(one_time2)

func _on_switch_a_2d_body_entered(body: Node2D) -> void:
	if only_once:
		%Doorway.queue_free()
		%SwitchA2D.queue_free()
		%Switch.queue_free()
		%Switch2.set_visible(true)
		only_once = false
		DungeonSignals.only_once.emit()
		DungeonSignals.DisplayText.emit('You opened a door!')
		
func one_time2():
	only_once = false
