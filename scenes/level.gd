extends Node2D
var score = 0
var car_scene = preload("res://scenes/other_car.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("left"):
		$Car.position.x -= 350 * delta
	elif Input.is_action_pressed("right"):
		$Car.position.x += 350 * delta
	$Score.text = str(score)
	
func _on_timer_timeout():
	var cars_markers = $CarsStartPositions.get_children()
	var selected_car = cars_markers[randi() % cars_markers.size()]
	var car = car_scene.instantiate()
	add_child(car)
	car.position = selected_car.position
	$Timer.wait_time = 1.0
	if score > 100:
		$Timer.wait_time = 0.5
	if score > 200:
		$Timer.wait_time = 0.25


func _on_roud_body_exited(body):
	if body == $Car:
		game_over()

func game_over():
	$Car.hide()
	$Timer.stop()
	$GameOver.text = "המשחק נגמר. הניקוד שלך הוא: " + str(score)
	$GameOver.show()
	$StartButton.show()
	$ScoreTimer.stop()
	score = 0
	$Music.stop()
	$Roud/RoudImage.stop()
	
func _on_start_button_pressed():
	$Car.show()
	$Timer.start()
	$StartButton.hide()
	$ScoreTimer.start()
	$GameOver.hide()
	$Music.play()
	$Roud/RoudImage.play("road")
	
func _on_score_timer_timeout():
	score += 1
	if not $Music.playing:
		$Music.play()
	
func _on_car_car_entered():
	game_over()
