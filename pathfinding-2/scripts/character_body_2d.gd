extends CharacterBody2D


var speed_direction = Vector2()

const MAX_SPEED = 300
@onready var sprite_2d: Sprite2D = $Sprite2D

## Add a reference to the tile map layer terrain
@export var tile_map_layer_terrain:TileMapLayer

func _physics_process(delta):
	## Comment the next line using Ctrl-K or delete it
	# speed_direction.x = 0
	
	if Input.is_action_pressed("ui_left"):
		speed_direction.x = -1
		sprite_2d.scale.x = -1
	elif Input.is_action_pressed("ui_right"):
		speed_direction.x = 1
		sprite_2d.scale.x = 1
	else:
		speed_direction.x = 0
		
	if Input.is_action_pressed("ui_up"):
		speed_direction.y = -1
	elif Input.is_action_pressed("ui_down"):
		speed_direction.y = 1
	else:
		speed_direction.y = 0
		
	velocity = speed_direction.normalized() * MAX_SPEED * calculate_movement_modifier(global_position)
	move_and_slide()
	
## add the function to calculate the terrain movement modifier
func calculate_movement_modifier(pos):
	# map the player coordinates into tile map coordinates
	var player_cell = tile_map_layer_terrain.local_to_map(pos)
	# get data for this tile where the player is on
	var tile_data = tile_map_layer_terrain.get_cell_tile_data(player_cell)
	# custom_data_0 is the value of the tile terrain modifier
	return tile_data.custom_data_0
	

	
