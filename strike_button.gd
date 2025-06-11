extends TextureRect
class_name StrikeButton

@export var normal_texture: Texture2D;
@export var pressed_texture: Texture2D;

signal strike();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gui_input.connect(handle_gui_input);
	pass # Replace with function body.

func handle_gui_input(event: InputEvent):
	if (event is InputEventScreenTouch):
		print("touch", event.index, event.pressed);
		if (event.pressed):
			strike.emit();
			texture = pressed_texture;
		else:
			texture = normal_texture;
	return;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
