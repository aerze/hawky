extends TextureButton
class_name StickButton

@export var limit_offset: float = 0;
@export var limit_left: float = 0;
@export var limit_right: float = 100;

@onready var controller: Controller = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gui_input.connect(handle_gui_event);
	return;

func handle_gui_event(event: InputEvent):
	if (event is InputEventScreenDrag):
		set_stick_position(event.position.x);
	return;

func set_stick_position(x: float):
	#if (controller.invert_controls):
		#print(">> x:", x, " ox:", x - offset_left, " lx:", controller.size.x - limit_right, " rx:", controller.size.x)
		#var value = clampf(x - offset_left, controller.size.x - limit_right, controller.size.x);
		#position.x = value;
		#return;
	#else:
	print(">> x:", x, " ox:", x + offset_left, " lx:", limit_left, " rx:", limit_right)
	var value = clampf(x + offset_left, limit_left, limit_right)
	position.x = value;
	return;

func get_value():
	return (position.x - limit_left)/(limit_right- limit_left);
