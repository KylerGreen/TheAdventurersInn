extends Node2D

var only_once : bool = true
@onready var creak = %Creak

func _ready() -> void:
	DungeonSignals.only_once.connect(one_time)
	
func one_time():
	only_once = false

func _on_chest_a_2d_body_entered(body: Node2D) -> void:
	if only_once:
		%Chest.queue_free()
		%Chest2.set_visible(true)
		only_once = false
		DungeonSignals.only_once2.emit()
		DungeonSignals.DisplayText.emit('You looted a chest!')
		creak.play()
