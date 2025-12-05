extends CharacterBody3D
class_name Player

@export var move_speed: float = 3.0
@export var gravity: float = 15.0
@export var jump_force: float = 6.0

enum State { IDLE, MOVE }
var state: State = State.IDLE

var velocity_y := 0.0
var last_dir := Vector3.FORWARD

var can_move: bool = true
var can_interact: bool = true

@onready var camera: Camera3D = $SpringArm3D/Camera3D

func _physics_process(delta):
	_apply_gravity(delta)
	_handle_jump()
	_state_machine(delta)

	velocity.y = velocity_y
	
	move_and_slide()

func _get_input_direction() -> Vector3:
	var dir: Vector2 = Vector2.ZERO
	if can_move:
		dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	return Vector3(dir.x, 0, dir.y).rotated(Vector3.UP, camera.global_rotation.y).normalized()

#  GRAVITY
func _apply_gravity(delta):
	if not is_on_floor():
		velocity_y -= gravity * delta
	else:
		if velocity_y < 0:
			velocity_y = 0

#  JUMP
func _handle_jump():
	if can_move and is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity_y = jump_force
		
#  STATE MACHINE
func _state_machine(delta):
	match state:
		State.IDLE:
			_state_idle(delta)
		State.MOVE:
			_state_move(delta)


#  STATES
func _state_idle(_delta):
	var dir = _get_input_direction()

	if dir != Vector3.ZERO:
		state = State.MOVE


func _state_move(_delta):
	var dir = _get_input_direction()

	if dir == Vector3.ZERO:
		state = State.IDLE
		velocity.x = 0
		velocity.z = 0
		return

	velocity.x = dir.x * move_speed
	velocity.z = dir.z * move_speed

	last_dir = dir
