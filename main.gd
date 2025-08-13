extends Node2D
class_name Main

@onready var p1_stick: StickButton = $Controls/Control/P1/StickButton
@onready var p1_strike: StrikeButton = $Controls/Control/P1/StrikeButton
@onready var p1_path: PathFollow2D = $Field/SouthPath/PathFollow2D
@onready var p1_guy: Guy = $P1/Guy1
@onready var p1_anim: AnimationPlayer = $P1/Anim
@onready var p1_strike_zone: StrikeZone = $P1/StrikeZone

@onready var p2_stick: StickButton = $Controls/Control/P2/StickButton
@onready var p2_strike: StrikeButton = $Controls/Control/P2/StrikeButton
@onready var p2_path: PathFollow2D = $Field/NorthPath/PathFollow2D
@onready var p2_guy: Guy = $P2/Guy1
@onready var p2_anim: AnimationPlayer = $P2/Anim
@onready var p2_strike_zone: StrikeZone = $P2/StrikeZone

@onready var reset_button: Button = $Controls/Control/ResetButton


@onready var special_audio: AudioStreamPlayer = $SpecialAudio
@onready var puck: Puck = $Puck

@export var strike_range = 180;
@export var strike_magnitude = 50000;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p1_strike.strike.connect(handle_p1_strike);
	p2_strike.strike.connect(handle_p2_strike);
	reset_button.pressed.connect(reset_puck);
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dev_close_game"):
		get_tree().quit()
	return

func reset_puck():
	puck.reset();


func handle_p1_strike():
	if (p1_anim.is_playing()):
		p1_anim.play("RESET");
	p1_anim.play("strike");

	var bodies = p1_strike_zone.get_overlapping_bodies();
	if (bodies.is_empty()):
		puck.apply_central_impulse(Vector2(0, -1));
		return;

	var right = p1_strike_zone.right + 20;
	var width = p1_strike_zone.width + 40;

	for body in bodies:
		if (body is Puck):
			var left = body.left;
			var difference = right - left;
			var percentage = difference / width;
			var strike_angle_deg = percentage * strike_range;
			var strike_angle = deg_to_rad(strike_angle_deg);
			var x = strike_magnitude * cos(strike_angle);
			var y = -strike_magnitude * sin(strike_angle);
			body.apply_central_force(Vector2(x, y));
			special_audio.pitch_scale = randf_range(1, 1.2);
			special_audio.play();
	return;

func handle_p2_strike():
	if (p2_anim.is_playing()):
		p2_anim.play("RESET");
	p2_anim.play("strike");

	var bodies = p2_strike_zone.get_overlapping_bodies();
	if (bodies.is_empty()):
		puck.apply_central_impulse(Vector2(0, -1));
		return;

	var right = p2_strike_zone.right + 20;
	var width = p2_strike_zone.width + 40;

	for body in bodies:
		if (body is Puck):
			var left = body.left;
			var difference = right - left;
			var percentage = difference / width;
			var strike_angle_deg = percentage * strike_range;
			var strike_angle = deg_to_rad(strike_angle_deg);
			var x = strike_magnitude * cos(strike_angle);
			var y = -strike_magnitude * sin(strike_angle);
			body.apply_central_force(Vector2(x, y));
			special_audio.pitch_scale = randf_range(1, 1.2);
			special_audio.play();
	return;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	p1_path.progress_ratio = p1_stick.get_value();
	p1_guy.global_position = p1_path.global_position;
	p1_guy.body.global_transform = p1_guy.global_transform;

	p2_path.progress_ratio = p2_stick.get_value();
	p2_guy.global_position = p2_path.global_position;
	p2_guy.body.global_transform = p2_guy.global_transform;
	return;
