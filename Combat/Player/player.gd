extends CharacterBody2D

signal attack

var health = 100
var IsDefending = false
var IsCountering = false
var IsDodging = false
var IsAttacking = false
var IsHealing = false
var action = 0
var reaction = 0


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
	
	
	
func Player_turn():
	if IsAttacking == true:
		AttackAnimation()
		attack.emit()
		IsAttacking = false
	elif IsHealing == true:
		health += 25
		IsHealing = false
		if health >= 100:
			health = 100
		%PlayerHealth.value = health
	action -= 1
	reaction -= 1
	%PlayerHand.visible = false
	%Enemy1.Enemy_turn()


func _on_player_hand_defend():
	if reaction == 0:
		reaction += 1
		IsDefending = true
		if action == 1 and reaction == 1:
			Player_turn()
	else:
		if action == 1 and reaction == 1:
			Player_turn()

func _on_player_hand_attack():
	if action == 0:
		action += 1
		IsAttacking = true
		if action == 1 and reaction == 1:
			Player_turn()
	else:
		if action == 1 and reaction == 1:
			Player_turn()
	
func _on_player_hand_heal():
	if action == 0:
		action += 1
		IsHealing = true
		if action == 1 and reaction == 1:
			Player_turn()
	else:
		if action == 1 and reaction == 1:
			Player_turn()

func _on_player_hand_counter():
	if reaction == 0:
		reaction += 1
		IsCountering = true
		if action == 1 and reaction == 1:
			Player_turn()
	else:
		if action == 1 and reaction == 1:
			Player_turn()

func _on_player_hand_dodge():
	if reaction == 0:
		reaction += 1
		IsDodging = true
		if action == 1 and reaction == 1:
			Player_turn()
	else:
		if action == 1 and reaction == 1:
			Player_turn()
