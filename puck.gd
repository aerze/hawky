extends RigidBody2D
class_name Puck

@onready var puck_audio: AudioStreamPlayer = $PuckAudio

@export var puck_sounds: Array[AudioStream] = [];

var left:
	get:
		return global_position.x - 20;

func _ready() -> void:
	body_entered.connect(handle_body_entered);
	return;

func handle_body_entered(body: Node):
	puck_audio.stop();
	puck_audio.pitch_scale = randf_range(0.9, 1.2);
	puck_audio.stream = puck_sounds.pick_random();
	puck_audio.play();
	return;
