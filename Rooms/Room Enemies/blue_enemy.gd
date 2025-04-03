extends Node2D

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	CombatSignals.Current_Enemy = get_node(self.get_path())
	DungeonSignals.Encounter.emit()
	
func _ready():
	CombatSignals.Enemy_Dead.connect(died)
	
func died():
	CombatSignals.Current_Enemy.queue_free()
