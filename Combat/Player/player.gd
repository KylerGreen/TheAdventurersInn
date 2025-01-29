extends CharacterBody2D

var health = 10

func _ready():
	%Player_Animation.play("Idle")
	%PlayerHealth.value = health

func _on_button_pressed():
	%Arm_Animation.visible = true
	%Player_Animation.play("Attack")
	%Arm_Animation.play("Attack")
	%Player_Attack.start()
	%Attack.visible = false

func _on_timer_timeout():
	%Player_Attack.stop()
	%Player_Animation.stop()
	%Arm_Animation.stop()
	%Arm_Animation.visible = false
	%Player_Animation.play("Idle")


func _on_enemy_attack_timeout():
	health -= 2
	%PlayerHealth.value = health
	if %PlayerHealth.value <= 0:
		queue_free()
	%Attack.visible = true
