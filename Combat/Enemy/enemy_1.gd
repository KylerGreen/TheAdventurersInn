extends CharacterBody2D

var health = 100

func _ready():
	%Enemy1_Animation.play("Idle")
	%EnemyHealth.value = health

func Enemy_turn():
	%Enemy_Attack.start()

func _on_timer_timeout():
	%EnemyHealth.value = health

func _on_enemy_attack_timeout():
	%Enemy_Attack.stop()


func _on_player_attack():
		health -= 15
		#%EnemyHealth.value = health
		if health <= 0:
			queue_free()
