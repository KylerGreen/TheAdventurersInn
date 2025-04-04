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
		creak.play()
		
		var item = randi_range(0,10)
		if item >= 0 and item <2:
			await get_tree().create_timer(1.0).timeout
			DungeonSignals.DisplayText.emit('You got a better Sword!')
			CombatSignals.Global_Sword += 5
		elif item >= 3 and item < 5:
			await get_tree().create_timer(1.0).timeout
			DungeonSignals.DisplayText.emit('You got better Armor!')
			CombatSignals.Global_Armor += 5
		elif item >= 5:
			await get_tree().create_timer(1.0).timeout
			DungeonSignals.DisplayText.emit('You got 10 Gold!')
			DungeonSignals.gold += 10
