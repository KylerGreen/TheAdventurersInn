extends Node2D

const SPAWN_ROOMS: Array = [preload("res://Rooms/Beginner Rooms/beginner_room_1_r.tscn"), 
preload("res://Rooms/Beginner Rooms/beginner_room_2_uld.tscn"), 
preload("res://Rooms/Beginner Rooms/beginner_room_3_u.tscn"), 
preload("res://Rooms/Beginner Rooms/beginner_room_4_d.tscn"), 
preload("res://Rooms/Beginner Rooms/beginner_room_5_l.tscn"), 
preload("res://Rooms/Beginner Rooms/beginner_room_6_lr.tscn"), 
preload("res://Rooms/Beginner Rooms/beginner_room_7uldr.tscn"), 
preload("res://Rooms/Beginner Rooms/beginner_room_8_ud.tscn")]

const INTERMEDIATE_ROOMS: Array = [preload("res://Rooms/Intermediate Rooms/intermediate_room_1.tscn"), 
preload("res://Rooms/Intermediate Rooms/intermediate_room_2.tscn"), 
preload("res://Rooms/Intermediate Rooms/intermediate_room_3.tscn"), 
preload("res://Rooms/Intermediate Rooms/intermediate_room_4.tscn")]

const END_ROOMS: Array = [preload("res://Rooms/Advanced Rooms/advanced_room_1.tscn"), 
preload("res://Rooms/Advanced Rooms/advanced_room_2.tscn"),
preload("res://Rooms/Advanced Rooms/advanced_room_3.tscn"), 
preload("res://Rooms/Advanced Rooms/advanced_room_4.tscn")]

@onready var player_scene = preload("res://Player.tscn")
@onready var camera = $Camera2D
var player
var last_room_position := Vector2(0,0)
var room_offset := Vector2(400, 0)
var active_rooms := []
var max_rooms := 5
var room_spawned := false

func _ready():
	player_scene.instantiate()
	player.position = Vector2(200, 200)
	add_child(player)
	camera.make_current()
	_spawn_new_room()
	
func _process(_delta) -> void:
	if not room_spawned and player.position.distance_to(last_room_position) < 600:
		_spawn_new_room()
		room_spawned = true
		
func _spawn_new_room(): 
	var room_scene: PackedScene
	if active_rooms.size() < 1:
		room_scene = SPAWN_ROOMS.pick_random()
		
	elif active_rooms.size() <  4:
		room_scene = INTERMEDIATE_ROOMS.pick_random()

	else: 
		room_scene = END_ROOMS.pick_random()
	
	var room_instance = room_scene.instantiate()
	room_instance.position = last_room_position
	
	add_child(room_instance)
	active_rooms.append(room_instance)
	
	last_room_position += room_offset
	
	if active_rooms.size() > max_rooms:
		var old_room = active_rooms.pop_front()
		old_room.queue_free()	
	
