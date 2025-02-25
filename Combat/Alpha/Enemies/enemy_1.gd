extends CharacterBody2D

var health = 100
var IsDefending = false
var IsCountering = false
var IsDodging = false
var rng = RandomNumberGenerator.new()
var DmgRecieved = 0


func _ready():
	%Enemy1_Animation.play("Idle")
	%EnemyHealth.value = health
	%EnemyHPCount.text = str('HP: ', health, '/100')


func Enemy_turn():
	var TurnAction = rng.randi_range(0, 10)
	if TurnAction >= 0 and TurnAction <= 4:
		IsDefending = true
		%Enemy_Attack.start()
		%Enemy1_Animation.play("Attack")
	elif TurnAction >= 5 and TurnAction <= 7:
		health += 10
		DmgRecieved = 10
		%DamageOnEnemy.visible = true
		%DamageOnEnemy.text = str('+', DmgRecieved)
		await get_tree().create_timer(1.0).timeout
		%DisplayDmg2.start()
		if health >= 100:
			health = 100
		%EnemyHealth.value = health
		IsCountering = true
		%PlayerHand.visible = true
	elif TurnAction >= 8 and TurnAction <= 10:
		IsDodging = true
		%Enemy_Attack.start()
		%Enemy1_Animation.play("Attack")
	%EnemyHPCount.text = str('HP: ', health, '/100')


func _on_timer_timeout():
	%EnemyHealth.value = health
	%EnemyHPCount.text = str('HP: ', health, '/100')
	%Enemy1_Animation.play("Idle")

func _on_enemy_attack_timeout():
	%Enemy_Attack.stop()
	%Enemy1_Animation.play("Idle")


func _on_player_attack():
	if IsDefending == true:
		health -= 5
		DmgRecieved = 5
		%Enemy1_Animation.play("Hurt")
		%DamageOnEnemy.visible = true
		%DamageOnEnemy.text = str('-', DmgRecieved)
		IsDefending = false
		
	elif IsCountering == true:
		%Enemy_Attack.start()
		IsCountering = false
		health -= 15
		DmgRecieved = 15
		%Enemy1_Animation.play("Hurt")
		%DamageOnEnemy.visible = true
		%DamageOnEnemy.text = str('-', DmgRecieved)
		
	elif IsDodging == true:
		var DodgeChance = rng.randi_range(0,100)
		if DodgeChance >= 70:
			health = health
			DmgRecieved = 0
			%DamageOnEnemy.visible = true
			%DamageOnEnemy.text = str(DmgRecieved)
		else:
			health -= 15
			DmgRecieved = 15
			%Enemy1_Animation.play("Hurt")
			%DamageOnEnemy.visible = true
			%DamageOnEnemy.text = str('-', DmgRecieved)
		IsDodging = false
		
	else:
		health -= 15
		DmgRecieved = 15
		%Enemy1_Animation.play("Hurt")
		%DamageOnEnemy.visible = true
		%DamageOnEnemy.text = str('-', DmgRecieved)
	%DisplayDmg2.start()
		
	if health <= 0:
		%Enemy1_Animation.play("Death")
		await get_tree().create_timer(2.0).timeout
		queue_free()
		
		%DamageOnEnemy.queue_free()

func _on_display_dmg_2_timeout():
	%DamageOnEnemy.visible = false
