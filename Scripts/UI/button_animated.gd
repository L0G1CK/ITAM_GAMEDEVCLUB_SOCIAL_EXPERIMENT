extends Button
class_name animated_button

var init_scale: Vector2

func _ready() -> void:
	init_scale = scale
	set_pivot_offset(get_size() / 2.0)
	focus_mode = Control.FOCUS_NONE
	
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)

func _on_mouse_entered() -> void:
	Animations.jump(self,Tween.TransitionType.TRANS_EXPO,[init_scale,0],[init_scale*1.1,0.1])
	if material: material.set_shader_parameter("enabled", true)
	#Sounds.play_sound("cell",-8,"SFX")

func _on_mouse_exited() -> void:
	Animations.jump(self,Tween.TransitionType.TRANS_EXPO,[init_scale*1.1,0],[init_scale,0.1])
	if material: material.set_shader_parameter("enabled", false)

func _on_button_down() -> void:
	Animations.jump(self,Tween.TransitionType.TRANS_EXPO,[init_scale*1.05,0],[init_scale,0.05])

func _on_button_up() -> void:
	Animations.jump(self,Tween.TransitionType.TRANS_EXPO,[init_scale,0],[init_scale*1.1,0.1])
