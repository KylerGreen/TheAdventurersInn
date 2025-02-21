extends CharacterBody2D

#Player Stats
var HP = 100
var Heals = 15
var Damage = 20

#Combat States
var Bolster = false
var Dodge = false
var Parry = false
var Counter = false
var disarm = false

func _ready():
	%Player_HP.text = str('HP: ', HP)
	CombatSignals.Player_Bolster.connect(Bolstered)
	CombatSignals.Player_Dodge.connect(Dodging)
	CombatSignals.Player_Parry.connect(Parrying)
	CombatSignals.Player_Counter.connect(Countering)
	CombatSignals.Player_Heal.connect(Healing)
	
	CombatSignals.Enemy_Swing.connect(Damaged)
	CombatSignals.Enemy_Disarm.connect(Disarmed)
	
func _process(delta):
	%Player_HP.text = str('HP: ', HP)


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
	if Dodge == true:
		pass
	else:
		HP -= %Skeleton.Damage
	
func Disarmed():
	%Skeleton.Disarm = true
