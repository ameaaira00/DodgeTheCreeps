extends Node

export(PackedScene) var mob_scene #inserts mobscene in inspector and allow us to choose the Mob scene we want to instance
var score

func _ready():
	randomize() #allows random number generator generates different random numbers each time the game is run
	

func _on_MobTimer_timeout(): #reate a mob instance, pick a random starting location along the Path2D, and set the mob in motion
	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation");
	mob_spawn_location.offset = randi()

	# Create a Mob instance and add it to the scene.
	var mob = mob_scene.instance()
	add_child(mob)

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)


func _on_ScoreTimer_timeout(): #increments the score by 1
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout(): #starts the other two timers
	$MobTimer.start()
	$ScoreTimer.start()


func game_over(): #handle what needs to happen when a game ends
	$Music.stop()
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game(): #will set everything up for a new game
	$Music.play()
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	
