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


func Enemy_turn():
	var TurnAction = rng.randi_range(0, 2)
	if TurnAction == 0:
		IsDefending = true
		%Enemy_Attack.start()
	elif TurnAction == 1:
		health += 10
		DmgRecieved = 10
		%DamageOnEnemy.visible = true
		%DamageOnEnemy.text = str('+', DmgRecieved)
		%DisplayDmg2.start()
		%EnemyHealth.value = health
		IsCountering = true
		%PlayerHand.visible = true
	elif TurnAction == 2:
		IsDodging = true
		%Enemy_Attack.start()


func _on_timer_timeout():
	%EnemyHealth.value = health

func _on_enemy_attack_timeout():
	%Enemy_Attack.stop()


func _on_player_attack():
	if IsDefending == true:
		health -= 5
		DmgRecieved = 5
		%DamageOnEnemy.visible = true
		%DamageOnEnemy.text = str('-', DmgRecieved)
		IsDefending = false
		
	elif IsCountering == true:
		%Enemy_Attack.start()
		IsCountering = false
		health -= 15
		DmgRecieved = 15
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
			%DamageOnEnemy.visible = true
			%DamageOnEnemy.text = str('-', DmgRecieved)
		IsDodging = false
		
	else:
		health -= 15
		DmgRecieved = 15
		%DamageOnEnemy.visible = true
		%DamageOnEnemy.text = str('-', DmgRecieved)
	%DisplayDmg2.start()
		
	if health <= 0:
		queue_free()
	

func _on_display_dmg_2_timeout():
	%DamageOnEnemy.visible = false
