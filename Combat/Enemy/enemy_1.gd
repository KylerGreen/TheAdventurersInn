extends CharacterBody2D

var health = 10

func _ready():
	%Enemy1_Animation.play("Idle")
	%EnemyHealth.value = health

func Enemy_turn():
	%Enemy_Attack.start()

func _on_timer_timeout():
	health -= 2
	%EnemyHealth.value = health
	if health <= 0:
		queue_free()
	Enemy_turn()


func _on_enemy_attack_timeout():
	%Enemy_Attack.stop()
