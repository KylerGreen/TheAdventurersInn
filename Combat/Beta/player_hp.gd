extends Label

var HP = 100
var Bolster = false
var Base = 0

func _ready():
	CombatSignals.Player_Attack.connect(DMG_Recieved)
	CombatSignals.Player_Bolster.connect(Bolstered)
	%Player_HP.text = str('HP: ', HP)

func Bolstered():
	Bolster = true

func DMG_Recieved():
	if Bolster == true:
		HP -= (30 * 1.3)
	else:
		HP -= 30
	if HP <= 0:
		HP = 0
	
func _process(delta):
	%Player_HP.text = str('HP: ', HP)
