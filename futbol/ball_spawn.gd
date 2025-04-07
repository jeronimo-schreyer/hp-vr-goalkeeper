extends Node3D


signal ball_spawned(timer)


@export var linear_velocity : Vector3
@export var ball_scene : PackedScene


func _on_cooldown_timeout():
	var new_ball = ball_scene.instantiate()
	add_child(new_ball)

	var vel = linear_velocity
	vel.x = randf_range(-1.0, 1.0)
	new_ball.linear_velocity = vel

	$AudioStreamPlayer.play()

	await get_tree().process_frame
	ball_spawned.emit(new_ball.get_node("Timer"))
