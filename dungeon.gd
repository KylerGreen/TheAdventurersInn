extends Node2D

const SPAWN_ROOMS: Array = [preload("res://Rooms/Beginner Rooms/beginner_room_1.tscn"), preload("res://Rooms/Beginner Rooms/beginner_room_3.tscn"), preload("res://Rooms/Beginner Rooms/beginner_room_4.tscn"), preload("res://Rooms/Beginner Rooms/beginner_room_2.tscn"), preload("res://Rooms/Beginner Rooms/beginner_room_1010.tscn"), preload("res://Rooms/Beginner Rooms/beginner_room_5.tscn")]
const INTERMEDIATE_ROOMS: Array = [preload("res://Rooms/Intermediate Rooms/intermediate_room_6.tscn"),preload("res://Rooms/Intermediate Rooms/intermediate_room_5.tscn"), preload("res://Rooms/Intermediate Rooms/intermediate_room_2.tscn"), preload("res://Rooms/Intermediate Rooms/intermediate_room_3.tscn")]
const ADVANCED_ROOMS: Array = [preload("res://Rooms/Advanced Rooms/advanced_room_2.tscn"), preload("res://Rooms/Advanced Rooms/advanced_room_3.tscn"), preload("res://Rooms/Advanced Rooms/advanced_room_444.tscn"), preload("res://Rooms/Advanced Rooms/advanced_room_555.tscn"), preload("res://Rooms/Advanced Rooms/advanced_room_666.tscn"), preload("res://Rooms/Advanced Rooms/advanced_room_777.tscn"), preload("res://Rooms/Advanced Rooms/advanced_room_888.tscn")]
const game_over = preload("res://Game Over Screen/game_over_screen.tscn")

@onready var player = %Player3
@onready var camera = $Camera2D
@onready var skeleton = %Skeleton_Sound
@onready var ambiance_sounds = [%Dungeon_Ambiance, %Dungeon_Echo]
@onready var timer_1 = $Timer

var active_rooms := []
var occupied_positions := {} 
var max_rooms := 20
var room_width = 280
var room_height = 280
var room_margin = 40
var combat_screen = preload("res://Combat/Beta/Combat_2.tscn")
var combat
var saved_position_x
var saved_position_y

func _ready():
	player.global_position = Vector2(15,-15)
	_spawn_new_room(Vector2(0,0))
	DungeonSignals.DisplayText.emit('The Depths')

	print("Active rooms after init:", active_rooms.size())
	# Room Signals
	DungeonSignals.Encounter.connect(Encountered)
	DungeonSignals.combat_done.connect(combat_finished)
	
	var wait_time_1 = randi() % 241 + 60
	timer_1.start(wait_time_1)
	
func _process(_delta) -> void:
	if active_rooms.size() > 0:
		var last_room = active_rooms.back()
		var next_room = last_room.position + Vector2(room_width + room_margin, 0)

		if player.global_position.x >= last_room.position.x + (room_width/2):
			print("Player moved far enough, spawning new room...")

			if Vector2i(next_room) not in occupied_positions:
				_spawn_new_room(next_room)
			
func _spawn_new_room(pos: Vector2):
	var pos_int = Vector2i(pos)
	if pos_int in occupied_positions:
		
		print("Room at", pos, "already occupied")
		return
	var room_scene: PackedScene
	
	if active_rooms.size() < 1:
		room_scene = SPAWN_ROOMS.pick_random()
		
	elif active_rooms.size() > 1 and active_rooms.size()<= 10:
		room_scene = INTERMEDIATE_ROOMS.pick_random()

	elif active_rooms.size() <= 20: 
		room_scene = ADVANCED_ROOMS.pick_random()
		
	elif active_rooms.size() == 21: 
		room_scene = game_over
		
	if room_scene == null:
		print("Error: No room selected")
	 
	var room_instance = room_scene.instantiate()
	room_instance.position = pos
	add_child(room_instance)
	active_rooms.append(room_instance)
	occupied_positions[pos_int] = true  

	print("Spawned room at:", room_instance.position) 
	print("Occupied positions:", occupied_positions.keys())
		
	print("Total active rooms:", active_rooms.size())
	print("Spawned new room at: ", room_instance.position)
	
	if active_rooms.size() > max_rooms:
		var old_room = active_rooms.pop_front()
		occupied_positions.erase(Vector2i(old_room.position))
		old_room.queue_free()	
		
func _on_timer_timeout():
	print("Timer triggered")
	ambiance()
	
func ambiance():	
	var sound = ambiance_sounds.pick_random()
	
	if !sound.playing:
		sound.play()
		
	var wait_time_1 = randi() % 241 + 60
	timer_1.start(wait_time_1)
	
func Encountered():
	saved_position_x = %Player3.position.x
	saved_position_y = %Player3.position.y
	skeleton.process_mode = Node.PROCESS_MODE_ALWAYS
	skeleton.play()
	combat = combat_screen.instantiate()
	combat.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().current_scene.add_child(combat)
	combat.position.x = 0
	combat.position.y = 0
	combat.scale.x = .5
	combat.scale.y = .5
	%Player3.position.x = 300
	%Player3.position.y = 200
	%Camera2D.zoom = Vector2(0.75, 0.75)
	get_tree().paused = true

func combat_finished():
	get_tree().paused = false
	combat.queue_free()
	%Camera2D.zoom = Vector2(1.7, 1.7)
	%Player3.position.x = saved_position_x
	%Player3.position.y = saved_position_y
