extends Node2D

var HP = 0
var Damage = 0
var Heals = 0

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
			HP = 130
			Damage = 15
			Heals = 10
		elif Skeleton == 1:
			HP = 70
			Damage = 20
			Heals = 10
		elif Skeleton == 2:
			HP = 90
			Damage = 10
			Heals = 15
		elif Skeleton == 3:
			HP = 100
			Damage = 10
			Heals = 10
			
	%Enemy_HP.text = str('HP: ', HP)
	CombatSignals.Enemy_Bolster.connect(Bolstered)
	CombatSignals.Enemy_Dodge.connect(Dodging)
	CombatSignals.Enemy_Parry.connect(Parrying)
	CombatSignals.Enemy_Counter.connect(Countering)
	CombatSignals.Enemy_Heal.connect(Healing)
	
	CombatSignals.Player_Swing.connect(Damaged)
	CombatSignals.Player_Disarm.connect(Disarmed)
	
func _process(delta):
	%Enemy_HP.text = str('HP: ', HP)
	if HP <= 0:
		HP = 0


func Bolstered():
	Bolster = 1.5
	
func Dodging():
	Dodge = true
	
func Parrying():
	Parry = 0.5
	
func Countering():
	Counter = true
	
func Healing():
	HP += Heals
	
func Damaged():
	var DMG_Recieved = (%Player.Damage + %Player.Sword) * %Player.Bolster * Parry
	$DamageCounter.text = str('-',DMG_Recieved)
	await get_tree().create_timer(1.0).timeout
	$DamageCounter.text = str('')
	if Dodge == true:
		HP = HP
		Dodge = false
	elif Counter == true:
		HP -= DMG_Recieved
		%Player.HP -= (Damage * 0.5)
		Counter = false
	else:
		HP -= DMG_Recieved
	%Player.Bolster = 1
	Parry = 1
	
func Disarmed():
	%Player.Disarm = true
