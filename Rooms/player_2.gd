extends CharacterBody2D

# Variables
var combat_screen = preload("res://Combat/Alpha/combat_screen.tscn")
@onready var footsteps = %Footstep
@onready var skeleton = %Skeleton_Sound
var current_display = null

func _ready() -> void:
	$Important_Text.visible = false
	DungeonSignals.DisplayText.connect(Lever_Pushed)
	DungeonSignals.DisplayText.connect(Floor1_Message)
	
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
	
	if current_display != null:
		var original_min_size = $Important_Text.custom_minimum_size.x
		var label = $Important_Text
		var original_font_size = label.get_theme_font_size("font_size")
		var original_stylebox = label.get_theme_stylebox("normal")
		$Important_Text.custom_minimum_size.x = original_min_size
		label.add_theme_stylebox_override("normal", original_stylebox)
		label.remove_theme_font_size_override("font_size")
		label.add_theme_font_size_override("font_size", 6)
		return
	
	$Important_Text.visible = true
	$Important_Text.text = set_text
	
	await get_tree().create_timer(3.0).timeout
	
	$Important_Text.visible = false
	current_display = null

# Display Text
func Floor1_Message(set_text : String):
	
	current_display = 'Floor1_Message'
	
	var label = $Important_Text
	label.visible = true
	label.text = set_text
	
	var original_min_size = $Important_Text.custom_minimum_size.x
	var original_font_size = label.get_theme_font_size("font_size")
	var original_stylebox = label.get_theme_stylebox("normal")

	$Important_Text.custom_minimum_size.x = (get_viewport().size.x - 600) * 0.8
	$Important_Text.add_theme_constant_override("align", HORIZONTAL_ALIGNMENT_CENTER)
	label.add_theme_font_size_override("font_size", original_font_size * 3)
	var border_style = StyleBoxFlat.new()
	border_style.border_width_top = 2
	border_style.border_width_bottom = 2
	border_style.border_width_left = 2
	border_style.border_width_right = 2
	border_style.border_color = Color(1, 1, 1)
	label.add_theme_stylebox_override("normal", border_style)
	
	await get_tree().create_timer(3.0).timeout
	
	$Important_Text.custom_minimum_size.x = original_min_size
	label.add_theme_stylebox_override("normal", original_stylebox)
	label.add_theme_font_size_override("font_size", 6)
	label.visible = false
	
