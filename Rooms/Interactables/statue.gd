extends Node2D

var only_once : bool = true
#@onready var stone = %Footstep

func _ready() -> void:
	DungeonSignals.only_once.connect(one_time)

func one_time():
	only_once = false

func _on_switch_3a_2d_body_entered(body: Node2D) -> void:
	if only_once:
		%Doorway.queue_free()
		%Switch3A2D.queue_free()
		%Switch.queue_free()
		%Switch2.set_visible(true)
		only_once = false
		DungeonSignals.DisplayText.emit('You found the hidden switch!')
		#stone.play()
