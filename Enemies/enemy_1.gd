extends CharacterBody2D

var health = 10

func _ready():
	%Enemy1_Animation.play("Idle")

func _on_button_pressed():
	health -= 1
	if health <= 0:
		queue_free()

#%EnemyHealth.set_value()
