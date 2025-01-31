extends Node2D

@export var noise_height_text: NoiseTexture2D
var noise: Noise

@onready var floor_tilemap_layer : TileMapLayer = $TileMapLayer/Floor
@onready var pillars_tilemap_layer : TileMapLayer = $TileMapLayer/Pillars
@onready var outer_walls_tilemap_layer: TileMapLayer= $TileMapLayer/Outer_Layer

var width : int = 100
var height : int = 100

@onready var tile_map = $TileMapLayer
var source_id = 0
var floor_atlas = Vector2i(1, 4)
var pillars_atlas = Vector2i(4, 1)
var outer_walls_atlas = Vector2i (0, 9)


func _ready():
	noise = noise_height_text.noise
	generate_world()
	add_border_walls()
	
func generate_world():
	for x in range(-width/2, width/2 ):
		for y in range(-height/2, height/2): 
			var noise_val: float = noise.get_noise_2d(x,y)
			
			if noise_val >= -0.1: 
				floor_tilemap_layer.set_cell(Vector2i(x,y), source_id, floor_atlas)
				
			else:
				pillars_tilemap_layer.set_cell(Vector2i(x,y), source_id, pillars_atlas)
				
func add_border_walls(): 
	for x in range(-width/2, width/2):
		outer_walls_tilemap_layer.set_cell(Vector2i(x, -height / 2), source_id, outer_walls_atlas)
		outer_walls_tilemap_layer.set_cell(Vector2i(x, height / 2 - 1), source_id, outer_walls_atlas)
	
	for y in range(-height/2, height/2):
		outer_walls_tilemap_layer.set_cell(Vector2i(-width/ 2, y), source_id, outer_walls_atlas)
		outer_walls_tilemap_layer.set_cell(Vector2i(width/ 2 - 1, y), source_id, outer_walls_atlas)
