extends TextureButton
class_name StickButton

@export var limit_offset: float = 20;
@export var limit_left: float = 0;
@export var limit_right: float = 100;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gui_input.connect(handle_gui_event);
	return;

func handle_gui_event(event: InputEvent):
	if (event is InputEventScreenDrag):
		set_stick_position(event.position.x);
	return;

func set_stick_position(x: float):
	var value = clampf(x + offset_left, limit_left, limit_right)
	global_position.x = value;
	return;

func get_value():
	return (global_position.x - limit_left)/(limit_right- limit_left);
