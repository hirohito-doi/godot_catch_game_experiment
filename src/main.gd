extends Node

var fruit_scene = preload("res://src/fruit.tscn")
var point_scene = preload("res://src/point.tscn")

const MAX_LIFE = 3

var score = 0
var current_life = MAX_LIFE
var screen_size:Vector2


func _ready() -> void:
	$ScoreContainer/Score.text = str(score)
	screen_size = get_viewport().size


func _on_fruits_timer_timeout() -> void:
	var fruit_instance = fruit_scene.instantiate()
	fruit_instance.connect("get_fruit", get_point)
	fruit_instance.position = Vector2(randi_range(30, screen_size.x), 0)
	add_child(fruit_instance)


func get_point(point: int) -> void:
	var point_instance = point_scene.instantiate()
	var position_x = $Character.position.x - (point_instance.size.x / 2)
	point_instance.position = Vector2(position_x, $Character.position.y -70)
	point_instance.set_point(point)
	add_child(point_instance)
	
	score += point
	$ScoreContainer/Score.text = str(score)
