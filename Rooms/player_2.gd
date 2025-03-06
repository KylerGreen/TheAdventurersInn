extends CharacterBody2D

# Variables
var combat_screen = preload("res://Combat/Alpha/combat_screen.tscn")

# Player Movement
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 200
	move_and_slide()

# OpenStatueSwitch
func _on_statue_a_2d_body_entered(body: Node2D) -> void:
	var only_once : bool = true
	if only_once:
		%Doorway.queue_free()
		%StatueA2D.queue_free()
		only_once = false

# OpenDoorSwitch
func _on_area_2d_body_entered(body: Node2D) -> void:
	var only_once : bool = true
	if only_once:
		%Doorway.queue_free()
		%SwitchA2D.queue_free()
		%Switch.queue_free()
		%Switch2.set_visible(true)
		only_once = false

# Encounter
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	get_tree().paused = true
	var combat = combat_screen.instantiate()
	get_parent().add_child(combat)
	combat.process_mode = Node.PROCESS_MODE_ALWAYS
	get_parent().add_child(combat)
	combat.position = Vector2(150, 150)
