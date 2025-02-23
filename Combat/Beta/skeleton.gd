extends CharacterBody2D

#Skeleton Stats
var HP = 90
var Heals = 10
var Damage = 10

#Combat States
var Bolster = false
var Dodge = false
var Parry = false
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
	Bolster = true
	
func Dodging():
	Dodge = true
	
func Parrying():
	Parry = true
	
func Countering():
	Counter = true
	
func Healing():
	HP += Heals
	
func Damaged():
	HP -= %Player.Damage
	
func Disarmed():
	%Player.Disarm = true
