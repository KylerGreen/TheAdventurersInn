extends CharacterBody2D

var health = 10

func _ready():
	%Enemy1_Animation.play("Idle")
	%EnemyHealth.value = health

func _on_button_pressed():
	health -= 2
	%EnemyHealth.value = health
	if health <= 0:
		queue_free()
