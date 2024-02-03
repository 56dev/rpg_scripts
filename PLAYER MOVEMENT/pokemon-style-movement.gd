extends Node2D

class InputBuffer:
	
	const dir_inputs = [
		"left",
		"right",
		"up",
		"down"
	]
	
	var input_array = []
	
	func update():
		_store_input()
		_release_input()
	
	func get_first_input():
		if len(input_array) == 0:
			return "zero"
		return input_array[0]
	
	
	func _store_input():
		for d in dir_inputs:
			if Input.is_action_just_pressed(d):
				input_array.append(d)
	func _release_input():
		for d in dir_inputs:
			if not Input.is_action_pressed(d):
				input_array.erase(d)

@export var SPEED = 4
@export var PIXEL_INTERVAL = 16
@export var SPRINT_MULTIPLIER = 2

@onready var INPUT_BUFFER = InputBuffer.new()
@onready var current_movement_dir : Vector2 = Vector2(0, 0)
@onready var true_position : Vector2 = self.position
@onready var facing_dir : Vector2 = Vector2(0, 1)

var _dir_collisions_bit_array = [false, false, false, false]

func _ready():
	INPUT_BUFFER = InputBuffer.new()
	true_position = self.position
	current_movement_dir = Vector2(0, 0)
	


func _physics_process(delta):
	
	const dir_dict = {
		"right" : Vector2(1, 0),
		"down" : Vector2(0, 1),
		"left" : Vector2(-1, 0),
		"up" : Vector2(0, -1),
		"zero" : Vector2(0, 0)
	}
	const dir_arr = [
		"right",
		"down",
		"left",
		"up",
	]
	
	var speed = SPEED
	
	if Input.is_key_pressed(KEY_SHIFT):
		speed *= SPRINT_MULTIPLIER
	
	print(self.position)
	
	var dir_str = INPUT_BUFFER.get_first_input()
	
	if dir_str != "zero":
		facing_dir = dir_dict[dir_str]
	
	INPUT_BUFFER.update()
	if self.global_position.x != true_position.x or self.global_position.y != true_position.y:
		self.global_position.x = int(move_toward(self.global_position.x, true_position.x, speed))
		self.global_position.y = int(move_toward(self.global_position.y, true_position.y, speed))
		return
	
	current_movement_dir = dir_dict[dir_str]
	
	for i in 4:
		if _dir_collisions_bit_array[i] == true:
			if dir_str == dir_arr[i]:
				return

	true_position += current_movement_dir * PIXEL_INTERVAL 



func _on_detector_right_body_entered(body):
	_dir_collisions_bit_array[0] = true
	pass # Replace with function body.


func _on_detector_right_body_exited(body):
	_dir_collisions_bit_array[0] = false

func _on_detector_down_body_entered(body):
	_dir_collisions_bit_array[1] = true


func _on_detector_down_body_exited(body):
	_dir_collisions_bit_array[1] = false

func _on_detector_left_body_entered(body):
	_dir_collisions_bit_array[2] = true
	


func _on_detector_left_body_exited(body):
	_dir_collisions_bit_array[2] = false

func _on_detector_up_body_entered(body):
	_dir_collisions_bit_array[3] = true


func _on_detector_up_body_exited(body):
	_dir_collisions_bit_array[3] = false

	
