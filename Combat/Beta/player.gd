extends CharacterBody2D

#Player Stats
var HP = 100
var Heals = 15
var Damage = 20
var XP = 0

#Player Inventory
var Gold = 0
var Sword = 0
var Armor = 0

#Combat States
var Bolster = 1
var Dodge = false
var Parry = 1
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
	
	####### Create a Level up function #######
	if XP >= 100:
		pass


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
	var DMG_Recieved = %Skeleton.Damage * %Skeleton.Bolster * Parry
	
	if Dodge == true:
		HP = HP
		Dodge = false
	elif Counter == true:
		HP -= DMG_Recieved
		%Skeleton.HP -= ((Damage + Sword) * 0.5)
		Counter = false
	else:
		HP -= DMG_Recieved
	%Skeleton.Bolster = 1
	Parry = 1
	
func Disarmed():
	%Skeleton.Disarm = true
