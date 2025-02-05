class_name Card extends Node2D

@export var card_name: String = "Card Name"
@export var card_ability: String = "Card Ability"
@export var card_rank: int = 1
@export var card_image: Node2D

@onready var name_lbl: Label = $CardBackground/Name
@onready var cr_display: Label = $CRDisplay/CR_Label
@onready var ability_lbl: Label = $AbilityBox/Ability
@onready var re_action: Label = $ActionReaction/Action_Or_Reaction

func _ready():
	name_lbl.set_text(card_name)
	cr_display.set_text(str(card_rank))
	ability_lbl.set_text(card_ability)
	

#func update_text(new_text):
	#name_label.text = new_text
