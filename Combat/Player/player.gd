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
var rng = RandomNumberGenerator.new()
var DmgRecieved = 0

func _ready():
	%Player_Animation.play("Idle")
	%PlayerHealth.value = health
	%HPCount.text = str('HP: ', health, '/100')

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
	
	%Player_Animation.play("Hurt")
	if IsCountering == true:
		await get_tree().create_timer(1.0).timeout
		AttackAnimation()
		attack.emit()
		DmgRecieved = 20
		health -= 20
		IsCountering = false
		%DamageOnPlayer.visible = true
		%DamageOnPlayer.text = str('-', DmgRecieved)
		
	elif IsDefending == true:
		DmgRecieved = 5
		health -= 5
		IsDefending = false
		%DamageOnPlayer.visible = true
		%DamageOnPlayer.text = str('-', DmgRecieved)
		
	elif IsDodging == true:
		var DodgeChance = rng.randi_range(0,100)
		if DodgeChance >= 70:
			health -= 0
			DmgRecieved = 0
			%DamageOnPlayer.visible = true
			%DamageOnPlayer.text = str('-', DmgRecieved)
		else:
			health -= 20
			DmgRecieved = 20
			%DamageOnPlayer.visible = true
			%DamageOnPlayer.text = str('-', DmgRecieved)
		IsDodging = false
		
	else:
		health -= 20
		DmgRecieved = 20
		%DamageOnPlayer.visible = true
		%DamageOnPlayer.text = str('-', DmgRecieved)
	%PlayerHealth.value = health
	%HPCount.text = str('HP: ', health, '/100')
	
	if %PlayerHealth.value <= 0:
		%Player_Animation.play("Death")
		await get_tree().create_timer(2.0).timeout
		queue_free()
		%DamageOnPlayer.queue_free()
	%DisplayDmg.start()
	%PlayerHand.visible = true
	
	
func Player_turn():
	if IsAttacking == true:
		AttackAnimation()
		attack.emit()
		IsAttacking = false
	elif IsHealing == true:
		health += 15
		DmgRecieved = 15
		%DamageOnPlayer.visible = true
		%DamageOnPlayer.text = str('+', DmgRecieved)
		IsHealing = false
		%DisplayDmg.start()
		if health >= 100:
			health = 100
		%PlayerHealth.value = health
	%HPCount.text = str('HP: ', health, '/100')
	action -= 1
	reaction -= 1
	%PlayerHand.visible = false
	if %Enemy1.health > 0:
		%EnemyTurn.start()



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


func _on_display_dmg_timeout():
	%DamageOnPlayer.visible = false


func _on_enemy_turn_timeout():
	%Enemy1.Enemy_turn()
	%EnemyTurn.stop()
