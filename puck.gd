extends RigidBody2D
class_name Puck

@onready var puck_audio: AudioStreamPlayer = $PuckAudio
@onready var puck_slide: AudioStreamPlayer = $PuckSlide

@export var puck_sounds: Array[AudioStream] = [];
@export var max_slide_velocity: float; 
@export var min_slide_velocity: float;

var left:
	get:
		return global_position.x - 20;

func _ready() -> void:
	body_entered.connect(handle_body_entered);
	return;

func handle_body_entered(_body: Node):
	puck_audio.stop();
	puck_audio.pitch_scale = randf_range(0.9, 1.2);
	puck_audio.stream = puck_sounds.pick_random();
	puck_audio.play();
	return;

func _process(_delta: float) -> void:
	print(linear_velocity.length())
	var slow_enough = linear_velocity.length() < max_slide_velocity;
	var fast_enough = linear_velocity.length() > min_slide_velocity;
	if slow_enough && fast_enough:
		if !puck_slide.playing:
			puck_slide.playing = true;
	else:
		if puck_slide.playing: 
			puck_slide.playing = false;
