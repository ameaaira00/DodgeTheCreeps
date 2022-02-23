extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready(): 
	#play the animation and randomly choose one of the three animation types
	$AnimatedSprite.playing = true
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func _on_VisibilityNotifier2D_screen_exited(): #make the mobs delete themselves when they leave the screen
	queue_free()
