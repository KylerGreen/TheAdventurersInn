extends CharacterBody2D

var health = 10
var is_defending = false

func _ready():
	%Player_Animation.play("Idle")
	%PlayerHealth.value = health

func _on_button_pressed():
	%Arm_Animation.visible = true
	%Player_Animation.play("Attack")
	%Arm_Animation.play("Attack")
	%Player_Attack.start()
	%Attack.visible = false
	%Defend.visible = false
	
func _on_defend_pressed():
	is_defending = true
	%Attack.visible = false
	%Defend.visible = false
	%Enemy1.Enemy_turn()

func _on_timer_timeout():
	%Player_Attack.stop()
	%Player_Animation.stop()
	%Arm_Animation.stop()
	%Arm_Animation.visible = false
	%Player_Animation.play("Idle")


func _on_enemy_attack_timeout():
	if is_defending == true:
		health -= 1
	else:
		health -= 2
	%PlayerHealth.value = health
	if %PlayerHealth.value <= 0:
		queue_free()
	%Attack.visible = true
	%Defend.visible = true
