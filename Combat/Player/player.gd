extends CharacterBody2D

signal attack

var health = 100
var IsDefending = false
var IsCountering = false
var IsDodging = false


func _ready():
	%Player_Animation.play("Idle")
	%PlayerHealth.value = health

func AttackAnimation():
	%Arm_Animation.visible = true
	%Player_Animation.play("Attack")
	%Arm_Animation.play("Attack")
	%Player_Attack.start()


func _on_timer_timeout():
	%Player_Attack.stop()
	%Player_Animation.stop()
	%Arm_Animation.stop()
	%Arm_Animation.visible = false
	%Player_Animation.play("Idle")

func _on_enemy_attack_timeout():
	if IsCountering == true:
		AttackAnimation()
		attack.emit()
		health -= 10
		IsCountering = false
	elif IsDefending == true:
		health -= 5
		IsDefending = false
	elif IsDodging == true:
		health -= 0
		IsDodging = false
	else:
		health -= 20
	%PlayerHealth.value = health
	if %PlayerHealth.value <= 0:
		queue_free()
	%PlayerHand.visible = true


func _on_player_hand_defend():
	IsDefending = true
	%PlayerHand.visible = false
	%Enemy1.Enemy_turn()

func _on_player_hand_attack():
	AttackAnimation()
	attack.emit()
	%PlayerHand.visible = false
	%Enemy1.Enemy_turn()
	
func _on_player_hand_heal():
	health += 25
	if health >= 100:
		health = 100
	%PlayerHealth.value = health
	%PlayerHand.visible = false
	%Enemy1.Enemy_turn()

func _on_player_hand_counter():
	IsCountering = true
	%PlayerHand.visible = false
	%Enemy1.Enemy_turn()

func _on_player_hand_dodge():
	IsDodging = true
	%PlayerHand.visible = false
	%Enemy1.Enemy_turn()
