extends Node2D

@onready var action_card_scene: PackedScene = preload("res://Card Scenes/Cards/action_swing.tscn")
@onready var reaction_card_scene: PackedScene = preload("res://Card Scenes/Cards/reaction_dodge.tscn")

@onready var spawn_point = $CanvasLayer/Spawn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var action_card = action_card_scene.instantiate()
	spawn_point.add_child(action_card)


func _on_button_2_pressed():
	var reaction_card = reaction_card_scene.instantiate()
	spawn_point.add_child(reaction_card)
