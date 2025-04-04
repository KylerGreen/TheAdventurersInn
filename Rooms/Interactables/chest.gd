extends Node2D

var only_once : bool = true
@onready var creak = %Creak

func _ready() -> void:
	DungeonSignals.only_once.connect(one_time)
	
func one_time():
	only_once = false

func _on_chest_a_2d_body_entered(body: Node2D) -> void:
	if only_once:
		%Chest1.queue_free()
		%Chest2.set_visible(true)
		only_once = false
		DungeonSignals.only_once2.emit()
		DungeonSignals.DisplayText.emit('You looted a chest!')
		var item = randi_range(0,10)
		if item >= 0 and item <3:
			await get_tree().create_timer(1.0).timeout
			DungeonSignals.DisplayText.emit('You got a better Sword!')
			CombatSignals.sword_got.emit()
		elif item >= 4 and item < 6:
			await get_tree().create_timer(1.0).timeout
			DungeonSignals.DisplayText.emit('You got better Armor!')
			CombatSignals.armor_got.emit()
		elif item >= 6:
			await get_tree().create_timer(1.0).timeout
			DungeonSignals.DisplayText.emit('You got 10 Gold!')
			DungeonSignals.gold += 10
		creak.play()
