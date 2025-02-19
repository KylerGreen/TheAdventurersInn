extends Label

var HP = 100
var Bolster = false
var Dodge = false
var Parry = false
var Counter = false
var Base = 0

func _ready():
	%Player_HP.text = str('HP: ', HP)
	CombatSignals.Player_Bolster.connect(Bolstered)
	CombatSignals.Player_Dodge.connect(Dodging)
	CombatSignals.Player_Parry.connect(Parrying)
	CombatSignals.Player_Counter.connect(Countering)

	
func _process(delta):
	%Player_HP.text = str('HP: ', HP)

func Bolstered():
	pass
	
func Dodging():
	pass
	
func Parrying():
	pass
	
func Countering():
	pass
	
