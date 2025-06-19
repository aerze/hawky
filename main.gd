extends Node2D
class_name Main

@onready var p1_stick: StickButton = $CanvasLayer/Control/Controller/StickButton
@onready var p1_strike: StrikeButton = $CanvasLayer/Control/Controller/StrikeButton
@onready var p1_path: PathFollow2D = $Team/Path2D/PathFollow2D
@onready var p1_guy: Guy = $Team/Guy1
@onready var p1_anim: AnimationPlayer = $Team/Anim
@onready var p1_strike_zone: StrikeZone = $Team/StrikeZone
@onready var special_audio: AudioStreamPlayer = $SpecialAudio

@export var strike_range = 180;
@export var strike_magnitude = 50000;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p1_strike.strike.connect(handle_p1_strike);
	pass # Replace with function body.

func handle_p1_strike():
	if (p1_anim.is_playing()):
		p1_anim.play("RESET");
	p1_anim.play("strike");

	var bodies = p1_strike_zone.get_overlapping_bodies();
	if (bodies.is_empty()): return;

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
			special_audio.pitch_scale = randf_range(1, 1.2);
			special_audio.play();
			body.apply_central_force(Vector2(x, y));
	return;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	p1_path.progress_ratio = p1_stick.get_value();
	p1_guy.global_position = p1_path.global_position;
	p1_guy.body.global_transform = p1_guy.global_transform;
	return;
