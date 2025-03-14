extends CharacterBody2D

# Variables
var combat_screen = preload("res://Combat/Alpha/combat_screen.tscn")
@onready var footsteps = %Footstep
@onready var skeleton = %Skeleton_Sound

func _ready() -> void:
	$Important_Text.visible = false
	DungeonSignals.DisplayText.connect(Lever_Pushed)
	DungeonSignals.DisplayText.connect(Floor1_Message) # 
	
# Player Movement
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 200
	
	if direction.length() > 0:
		if not footsteps.playing:
			footsteps.play()
	
	else:
		footsteps.stop()
		
	move_and_slide()

# OpenStatueSwitch
func _on_statue_a_2d_body_entered(body: Node2D) -> void:
	var only_once : bool = true
	if only_once:
		%Doorway.queue_free()
		%StatueA2D.queue_free()
		only_once = false

# OpenDoorSwitch
func _on_area_2d_body_entered(body: Node2D) -> void:
	var only_once : bool = true
	if only_once:
		%Doorway.queue_free()
		%SwitchA2D.queue_free()
		%Switch.queue_free()
		%Switch2.set_visible(true)
		only_once = false

# Encounter
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	skeleton.play()
	get_tree().paused = true
	var combat = combat_screen.instantiate()
	get_parent().add_child(combat)
	combat.process_mode = Node.PROCESS_MODE_ALWAYS
	get_parent().add_child(combat)
	combat.position = Vector2(150, 150)

# Display Text
func Lever_Pushed(set_text : String):
	$Important_Text.visible = true
	$Important_Text.text = set_text
	await get_tree().create_timer(3.0).timeout
	$Important_Text.visible = false

# Display Text
func Floor1_Message(set_text : String):
	$Important_Text.visible = true
	$Important_Text.text = set_text
	await get_tree().create_timer(3.0).timeout
	$Important_Text.visible = false
