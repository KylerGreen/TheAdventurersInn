extends Node2D

var previous_position: Vector2

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	CombatSignals.Current_Enemy = get_node(self.get_path())
	DungeonSignals.Encounter.emit()
	
func _ready():
	CombatSignals.Enemy_Dead.connect(died)
	previous_position = position
	
func died():
	CombatSignals.Current_Enemy.queue_free()

func _process(delta):
	var is_moving = position != previous_position
	
	if is_moving:
		%SkeletonAnimation.play("Move")
		
	else:
		%SkeletonAnimation.play("Idle")
