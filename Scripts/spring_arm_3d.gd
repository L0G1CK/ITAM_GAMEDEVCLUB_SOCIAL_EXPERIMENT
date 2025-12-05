extends SpringArm3D

@export var mouse_sensibility: float = 0.005
@export_range(-90.0, 0.0, 0.1, "radians_as_degrees") var min_vertical_angle: float = -PI/2
@export_range(0.0, 90.0, 0.1, "radians_as_degrees") var max_vertical_angle: float = PI/4

var character: Player

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	character = get_parent()
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		character.rotation.y -= event.relative.x * mouse_sensibility
		rotation.x -= event.relative.y * mouse_sensibility
		rotation.x = clamp(rotation.x, min_vertical_angle, max_vertical_angle)
	
	if event.is_action_pressed("wheel_up"):
		if spring_length>0: spring_length -= 1
	if event.is_action_pressed("wheel_down"):
		spring_length += 1
