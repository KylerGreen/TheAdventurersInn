@tool
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
	card_ability = _card_ability
	action_reaction = _action_reaction
	
	
	update_graphics()
	#name_lbl.set_text(_name)
	#cr_display.set_text(str(_cr))
	#ability_lbl.set_text(_card_ability)
	#re_action.set_text(_action_reaction)
	
func update_graphics():
	if name_lbl.get_text() != card_name:
		name_lbl.set_text(card_name)
	if cr_display.get_text() != str(card_rank):
		cr_display.set_text(str(card_rank))
	if ability_lbl.get_text() != card_ability:
		ability_lbl.set_text(card_ability)
	if re_action.get_text() != action_reaction:
		re_action.set_text(action_reaction)

	name_lbl.set_text(card_name)
	cr_display.set_text(str(card_rank))
	ability_lbl.set_text(card_ability)
	re_action.set_text(action_reaction)

func _process(delta):
	update_graphics()
	
