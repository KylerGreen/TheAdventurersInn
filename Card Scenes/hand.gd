extends Node2D

@export var hand_radius: int = 100

@onready var collision_shape: CollisionShape2D = $DebugShape
func get_card_position(angle: float):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


	# tool logic
	(collision_shape.shape as CircleShape2D)
