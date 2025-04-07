extends PersistentZone

@export var start_event: XRToolsRumbleEvent
@export var ball_event: XRToolsRumbleEvent

func scene_visible(user_data = null):
	$BallSpawn/Cooldown.start()
	$Whistle.play()
	$Viewport2Din3D/Viewport/UI.running = true
	XRToolsRumbleManager.add(self, start_event)


func _on_area_3d_body_entered(body: Node3D, hand:String) -> void:
	var tracker = $XROrigin3D/RightHand.tracker if hand == "right" else $XROrigin3D/LeftHand.tracker
	XRToolsRumbleManager.add(self, ball_event, [tracker])
	$Catch.play()

	check_if_end_game()


func _on_gol_body_entered(body: Node3D) -> void:
	if body is XRToolsPickable:
		$FootballStadiumADay/Gol/AudioStreamPlayer.play()
		body.get_node("Timer").stop()

		check_if_end_game()


func _on_ball_spawned(timer: Variant) -> void:
	var pelotas = int($Viewport2Din3D/Viewport/UI/GridContainer/Label6.text) + 1
	$Viewport2Din3D/Viewport/UI/GridContainer/Label6.text = str(pelotas)
	timer.connect("timeout", _on_ball_timeout)

	if pelotas == 10:
		$BallSpawn/Cooldown.stop()


func _on_ball_timeout():
	var atajadas = int($Viewport2Din3D/Viewport/UI/GridContainer/Label4.text) + 1
	$Viewport2Din3D/Viewport/UI/GridContainer/Label4.text = str(atajadas)


func check_if_end_game():
	if $BallSpawn/Cooldown.is_stopped():
		$GPUParticles3D.emitting = true
		await get_tree().create_timer(3.0).timeout
		$Whistle.play()
		$EndGameCrowd.play()
		$Viewport2Din3D/Viewport/UI.running = false
