@tool
extends XRToolsSceneBase


# Called when the node enters the scene tree for the first time.
func scene_visible(user_data = null):
	GameState.new_game(GameState.GameDifficulty.GAME_EASY)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
