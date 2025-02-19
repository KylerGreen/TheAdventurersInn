extends Label

var HP = 90
var Bolster = false
var Dodge = false
var Parry = false
var Counter = false
var Base = 0

func _ready():
	%Enemy_HP.text = str('HP: ', HP)
	CombatSignals.Enemy_Bolster.connect(Bolstered)
	CombatSignals.Enemy_Dodge.connect(Dodging)
	CombatSignals.Enemy_Parry.connect(Parrying)
	CombatSignals.Enemy_Counter.connect(Countering)
	
func _process(delta):
	%Enemy_HP.text = str('HP: ', HP)

func Bolstered():
	pass
	
func Dodging():
	pass
	
func Parrying():
	pass
	
func Countering():
	pass
