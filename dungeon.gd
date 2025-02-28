extends Node2D

const SPAWN_ROOMS: Array = [preload("res://Rooms/Beginner Rooms/beginner_room_1.tscn")]

const INTERMEDIATE_ROOMS: Array = [preload("res://Rooms/Intermediate Rooms/intermediate_room_2.tscn"), ]

const ADVANCED_ROOMS: Array = [preload("res://Rooms/Advanced Rooms/advanced_room_2.tscn")]

const game_over = preload("res://Game Over Screen/game_over_screen.tscn")

@onready var player = %Player3
@onready var camera = $Camera2D
var active_rooms := []
var occupied_positions := {} 
var max_rooms := 20
var room_width = 280
var room_height = 400
var room_margin = 40

func _ready():
	player.global_position = Vector2(15,-15)
	_spawn_new_room(Vector2(0,0))
	print("Active rooms after init:", active_rooms.size())
	
func _process(_delta) -> void:
	if active_rooms.size() > 0:
		var last_room = active_rooms.back()
		var next_room = last_room.position + Vector2(room_width + room_margin, 0)
		
		if player.global_position.x >= last_room.position.x + (room_width/2): 
			print("Player moved far enough, spawning new room...")
			
			if Vector2i(next_room) not in occupied_positions:
				_spawn_new_room(next_room)
			
			else: 
				print("Room at", next_room, "already exists")
		
func _spawn_new_room(pos: Vector2):
	var pos_int = Vector2i(pos)
	if pos_int in occupied_positions:
		print("Room at", pos, "already occupied")
		return
	var room_scene: PackedScene
	
	if active_rooms.size() < 1:
		room_scene = SPAWN_ROOMS.pick_random()
		
	elif active_rooms.size() < 10:
		room_scene = INTERMEDIATE_ROOMS.pick_random()

	elif active_rooms.size()< 19: 
		room_scene = ADVANCED_ROOMS.pick_random()
		
	else: 
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
	
