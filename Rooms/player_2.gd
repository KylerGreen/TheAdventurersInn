extends CharacterBody2D

var combat_screen = preload("res://Combat/Alpha/combat_screen.tscn")

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 200
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	var only_once : bool = true
	if only_once:
		%Doorway.queue_free()
		%Area2D.queue_free()
		%Switch.queue_free()
		%Switch2.set_visible(true)
		only_once = false
	
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if "Player3" in body.name:
		var combat = combat_screen.instantiate()
		get_parent().add_child(combat)
		queue_free()
		
		
		
