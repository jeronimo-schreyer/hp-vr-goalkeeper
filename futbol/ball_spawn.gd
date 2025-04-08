extends Node3D


signal ball_spawned(timer)


@export var ball_scene : PackedScene
@export var linear_velocity : Vector3
@export_range(0, 90, 0.1) var min_rand_range : float
@export_range(0, 90, 0.1) var max_rand_range : float


func _ready() -> void:
	randomize()


func _on_cooldown_timeout():
	var new_ball = ball_scene.instantiate()
	add_child(new_ball)

	var vel = linear_velocity
	vel.x = randf_range(min_rand_range, max_rand_range)

	if randi() % 2 == 1:
		vel.x = -vel.x
	new_ball.linear_velocity = vel

	$AudioStreamPlayer.play()

	await get_tree().process_frame
	ball_spawned.emit(new_ball.get_node("Timer"))
