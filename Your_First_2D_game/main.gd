extends Node

@export var mob_scene: PackedScene
var score

func _ready():
	pass

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$Deathsound.play()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	get_tree().call_group("mobs","queue_free")
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout():
	$HUD.update_score(score)
	score += 1


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0,250.0),0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
