extends Node2D
	

#Global Variables
var Action_is_there = false
var Reaction_is_there = false
var new_act_id = 1
var new_react_id = 2
var discard_id = 3
var Player_HP = 100
var Player_XP = 0
var Current_Enemy = Node2D
var Global_Sword = 0
var Global_Armor = 0

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
signal discarded
signal player_turn_over
signal invis_hand
signal sword_got
signal armor_got
signal player_dead

#Enemy Signals
signal Enemy_Swing
signal Enemy_Bolster
signal Enemy_Heal
signal Enemy_Disarm
signal Enemy_Dodge
signal Enemy_Parry
signal Enemy_Counter
signal enemy_action_phase
signal vis_hand
signal Enemy_Dead
