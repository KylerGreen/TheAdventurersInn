extends Node2D

const SPAWN_ROOMS: Array = [preload("res://Rooms/Beginner Rooms/beginner_room_1_r.tscn")]
#preload("res://Rooms/Beginner Rooms/beginner_room_2_uld.tscn"), 
#preload("res://Rooms/Beginner Rooms/beginner_room_3_u.tscn"), 
#preload("res://Rooms/Beginner Rooms/beginner_room_4_d.tscn"), 
#preload("res://Rooms/Beginner Rooms/beginner_room_5_l.tscn"), 
#preload("res://Rooms/Beginner Rooms/beginner_room_6_lr.tscn"), 
#preload("res://Rooms/Beginner Rooms/beginner_room_7uldr.tscn"), 
#preload("res://Rooms/Beginner Rooms/beginner_room_8_ud.tscn")]

const INTERMEDIATE_ROOMS: Array = [preload("res://Rooms/Intermediate Rooms/intermediate_room_1.tscn"), 
preload("res://Rooms/Intermediate Rooms/intermediate_room_2.tscn"), 
preload("res://Rooms/Intermediate Rooms/intermediate_room_3.tscn"), 
preload("res://Rooms/Intermediate Rooms/intermediate_room_4.tscn")]

const ADVANCED_ROOMS: Array = [preload("res://Rooms/Advanced Rooms/advanced_room_1.tscn"), 
preload("res://Rooms/Advanced Rooms/advanced_room_2.tscn"),	
preload("res://Rooms/Advanced Rooms/advanced_room_3.tscn"), 
preload("res://Rooms/Advanced Rooms/advanced_room_4.tscn")]

@onready var player = %Player3
@onready var camera = $Camera2D

var active_rooms := []
var max_rooms := 5
var room_size = Vector2(31, 0)

func _ready():
	player.global_position = Vector2(15,-15)
	_spawn_new_room(Vector2(0,0))
	print("Active rooms after init:", active_rooms.size())
	
func _process(_delta) -> void:
	if active_rooms.size() > 0:
		var last_room = active_rooms.back()
		var next_room = last_room.position + room_size
		
		if player.global_position.x >= last_room.position.x:
			print("Player moved far enough, spawning new room...")
			_spawn_new_room(next_room)
		
func _spawn_new_room(pos: Vector2):
	var room_scene: PackedScene
	
	if active_rooms.size() > 0:
		room_scene = SPAWN_ROOMS.pick_random()
		
	elif active_rooms.size() > 2:
		room_scene = INTERMEDIATE_ROOMS.pick_random()

	else: 
		room_scene = ADVANCED_ROOMS.pick_random()
		
	if room_scene == null:
		print("Error: No room selected")
	 
	var room_instance = room_scene.instantiate()
	room_instance.position = pos
	add_child(room_instance)
	active_rooms.append(room_instance)
		
	print("Total active rooms:", active_rooms.size())
	print("Spawned new room at: ", room_instance.position)
	
	if active_rooms.size() > max_rooms:
		var old_room = active_rooms.pop_front()
		old_room.queue_free()	
	
