extends CharacterBody2D

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 200
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	print('collided') # Replace with function body.
