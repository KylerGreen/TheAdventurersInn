extends Node2D

#Enemy Base Stats
var HP = 0
var Damage = 0
var Heals = 0
var XP = 0
var gold = 0
var MaxHP = 0

#Combat States
var Bolster = 1
var Dodge = false
var Parry = 1
var Counter = false
var Disarm = false

func _ready():
	var current_enemy = randi_range(0, 0)
	if current_enemy == 0:
		current_enemy = 'Skeleton'
		var Skeleton = randi_range(0, 3)
		if Skeleton == 0:
			HP = 120
			MaxHP = HP
			Damage = 20
			Heals = 10
			XP = 50
			gold = 10
		elif Skeleton == 1:
			HP = 60
			MaxHP = HP
			Damage = 25
			Heals = 10
			XP = 10
			gold = 5
		elif Skeleton == 2:
			HP = 90
			MaxHP = HP
			Damage = 20
			Heals = 15
			XP = 30
			gold = 5
		elif Skeleton == 3:
			HP = 80
			MaxHP = HP
			Damage = 20
			Heals = 10
			XP = 20
			gold = 5
			
	%Enemy_HP.text = str('HP: ', HP)
	$Enemy_health.max_value = HP
	$Enemy_health.value = HP
	CombatSignals.Enemy_Bolster.connect(Bolstered)
	CombatSignals.Enemy_Dodge.connect(Dodging)
	CombatSignals.Enemy_Parry.connect(Parrying)
	CombatSignals.Enemy_Counter.connect(Countering)
	CombatSignals.Enemy_Heal.connect(Healing)
	
	CombatSignals.Player_Swing.connect(Damaged)
	CombatSignals.Player_Disarm.connect(Disarmed)
	CombatSignals.player_turn_over.connect(enemy_turn)
	
func _process(delta):
	if HP >= MaxHP:
		HP = MaxHP
	%Enemy_HP.text = str('HP: ', HP)
	$Enemy_health.value = HP
	if HP <= 0:
		HP = 0
		await get_tree().create_timer(1.5).timeout
		CombatSignals.Enemy_Dead.emit()
		DungeonSignals.gold += %Enemy.gold
		%Player.XP += XP
		queue_free()


func Bolstered():
	Bolster = 1.5
	%DamageCounter.text = str('The Skeleton strengthens!')
	await get_tree().create_timer(1.0).timeout
	%DamageCounter.text = str('')
	
func Dodging():
	Dodge = true
	%DamageCounter.text = str('The Skeleton appears nimble!')
	await get_tree().create_timer(1.0).timeout
	%DamageCounter.text = str('')
	
func Parrying():
	Parry = 0.5
	%DamageCounter.text = str('The Skeleton defends!')
	await get_tree().create_timer(1.0).timeout
	%DamageCounter.text = str('')
	
func Countering():
	Counter = true
	%DamageCounter.text = str('The Skeleton reacts!')
	await get_tree().create_timer(1.0).timeout
	%DamageCounter.text = str('')
	
func Healing():
	HP += Heals
	%DamageCounter.text = str('The Skeleton heals ', Heals, ' HP')
	await get_tree().create_timer(1.0).timeout
	%DamageCounter.text = str('')
	
func Damaged():
	print("Damage Dealt")
	var DMG_Recieved = (%Player.Damage + %Player.Sword) * %Player.Bolster * Parry
	%DamageCounter.text = str('-',DMG_Recieved)
	await get_tree().create_timer(1.0).timeout
	%DamageCounter.text = str('')
	if Dodge == true:
		HP = HP
		Dodge = false
		%Player.Bolster = 1
	elif Counter == true:
		HP -= DMG_Recieved
		%Player.HP -= (Damage * 0.5)
		Counter = false
		%Player.Bolster = 1
	else:
		HP -= DMG_Recieved
		%Player.Bolster = 1
	Parry = 1
	
func Disarmed():
	%Player.Disarm = true

func enemy_turn():
	Dodge = false
	Counter = false
	
	await get_tree().create_timer(2.0).timeout
	if HP > 0:
		var Enemy_Action = randi_range(0, 10)
		if Enemy_Action > 0 and Enemy_Action <= 2:
			CombatSignals.Enemy_Counter.emit()
			CombatSignals.Enemy_Swing.emit()		
		elif Enemy_Action > 2 and Enemy_Action <= 4:
			CombatSignals.Enemy_Bolster.emit()
			CombatSignals.Enemy_Swing.emit()
		elif Enemy_Action > 4 and Enemy_Action <= 6:
			CombatSignals.Enemy_Heal.emit()
			CombatSignals.Enemy_Parry.emit()
		elif Enemy_Action > 6 and Enemy_Action <= 8:
			CombatSignals.Enemy_Disarm.emit()
			CombatSignals.Enemy_Dodge.emit()
		elif Enemy_Action > 8 and Enemy_Action <= 10:
			CombatSignals.Enemy_Parry.emit()
			CombatSignals.Enemy_Swing.emit()
		
		CombatSignals.vis_hand.emit()
