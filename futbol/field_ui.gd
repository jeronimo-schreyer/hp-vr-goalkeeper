extends ColorRect

@export var running := false

@onready var current_timestamp := 0.0

func _process(delta: float) -> void:
	if running:
		current_timestamp += delta

	$GridContainer/Label2.text = "%.2f" % current_timestamp
