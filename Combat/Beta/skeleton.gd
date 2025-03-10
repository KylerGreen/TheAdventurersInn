extends CharacterBody2D

#Skeleton Stats
var HP = 90
var Heals = 10
var Damage = 10

#Combat States
var Bolster = 1
var Dodge = false
var Parry = 1
var Counter = false
var Disarm = false

func _ready():
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
