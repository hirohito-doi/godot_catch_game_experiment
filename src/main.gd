extends Node

var character_scene = preload("res://src/character.tscn")
var fruit_scene = preload("res://src/fruit.tscn")
var ball_scene = preload("res://src/ball.tscn")
var point_scene = preload("res://src/point.tscn")
var character_instance

const MAX_LIFE = 3

var score 
var current_life:int
var screen_size:Vector2


func _ready() -> void:
	screen_size = get_viewport().size
	start_game()


func _on_generator_generate_ball() -> void:
	var ball_instance = ball_scene.instantiate()
	ball_instance.connect("get_injured", get_injured)
	add_child(ball_instance)
	ball_instance.position = Vector2($Generator.position.x, $Generator.position.y - 40)


func _on_fruits_timer_timeout() -> void:
	var fruit_instance = fruit_scene.instantiate()
	fruit_instance.connect("get_fruit", get_point)
	fruit_instance.position = Vector2(randi_range(30, screen_size.x), 0)
	add_child(fruit_instance)


func _on_restart_button_pressed() -> void:
	start_game()


func get_point(point: int) -> void:
	var point_instance = point_scene.instantiate()
	var position_x = character_instance.position.x - (point_instance.size.x / 2)
	point_instance.position = Vector2(position_x,  character_instance.position.y -70)
	point_instance.set_point(point)
	add_child(point_instance)
	
	score += point
	$ScoreContainer/Score.text = str(score)


func start_game() -> void:
	score = 0
	$ScoreContainer/Score.text = str(score)
	
	current_life = MAX_LIFE
	set_heart()
	
	character_instance = character_scene.instantiate()
	character_instance.set_position(Vector2(287, 289))
	add_child(character_instance)
	
	$FruitsTimer.start()
	$GameOver.visible = false
	$Blood/Container.visible = false


func get_injured() -> void:
	current_life -= 1
	set_heart()
	display_blood()
	
	# ゲーム終了判定
	if(current_life == 0):
		game_over()


func set_heart() -> void:
	var hearts = $HeartContainer.get_children()
	for i in range(MAX_LIFE):
		var heart = hearts[i]
		if current_life >= MAX_LIFE - i:
			heart.activate()
		else:
			heart.inactivate()


func display_blood() -> void:
	var target_blood = $Blood/Container/_1
	if current_life == 1:
		target_blood = $Blood/Container/_2
	elif  current_life == 0:
		target_blood = $Blood/Container/_3
		
	for item in $Blood/Container.get_children():
		if item == target_blood:
			item.visible = true
		else:
			item.visible = false
	$Blood/Container.visible = true
	$Blood/AnimationPlayer.play("show")


func game_over() -> void:
	character_instance.queue_free()
	$FruitsTimer.stop()
	$GameOver.visible = true
	$GameOver/AnimationPlayer.play("show")
