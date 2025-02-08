class_name Card extends Node2D

@export var card_name: String = "Card Name"
@export var card_ability: String = "Card Ability"
@export var card_rank: int = 1
@export var card_image: Sprite2D
@export var action_reaction: String = "Re?Action"

@onready var name_lbl: Label = $CardBackground/Name
@onready var cr_display: Label = $CRDisplay/CR_Label
@onready var ability_lbl: Label = $AbilityBox/Ability
@onready var re_action: Label = $ActionReaction/Action_Or_Reaction

func _ready():
	set_card_values(card_rank, card_name, card_ability, action_reaction)
	

func set_card_values(_cr: int, _name: String, _card_ability: String, _action_reaction: String):
	card_name = _name
	card_rank = _cr
	card_ability = card_ability
	action_reaction = _action_reaction
	
	name_lbl.set_text(_name)
	cr_display.set_text(str(_cr))
	ability_lbl.set_text(_card_ability)
	re_action.set_text(_action_reaction)
