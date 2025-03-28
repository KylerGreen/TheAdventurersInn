extends Node2D

func _ready() -> void:
	DungeonSignals.combat_done.connect(combat_finished)
	

#Global Variables
var Action_is_there = false
var Reaction_is_there = false

#Card Signals
signal type_check

#Player Signals
signal Player_Swing
signal Player_Bolster
signal Player_Heal
signal Player_Disarm
signal Player_Dodge
signal Player_Parry
signal Player_Counter
signal card_placed
signal player_action_phase
signal card_used

#Enemy Signals
signal Enemy_Swing
signal Enemy_Bolster
signal Enemy_Heal
signal Enemy_Disarm
signal Enemy_Dodge
signal Enemy_Parry
signal Enemy_Counter
signal enemy_action_phase


func combat_finished():
	queue_free()
