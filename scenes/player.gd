extends CharacterBody2D

@onready var animation_tree = $AnimationTree
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var attacking = false
var jumping =false
var friction = 40
var dead=false
var sleeping= false
var sleep_option = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var right=true
var invinsible= false

func _process(delta):
	if !dead:
		movement_animation()
	if sleeping:
		$AnimatedSprite2D.visible =true
	else:
		$AnimatedSprite2D.visible =false
		
		
	
func _physics_process(delta):
	# Add the gravity.
	
	if not is_on_floor():
		velocity.y += gravity * delta

	if !attacking and !dead and !sleeping:
		if Input.is_action_just_pressed("ui_up") and is_on_floor() and !dead and !attacking:
			velocity.y = JUMP_VELOCITY
			jumping=true
		if is_on_floor():
			jumping=false
				
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x =move_toward(velocity.x,0,friction)
	if attacking or dead or sleeping:
		if velocity.x!=0:
			velocity.x = move_toward(velocity.x,0,100)
	
	move_and_slide()
	if sleep_option == true and Input.is_action_pressed("use"):
		sleeping = true
		$"sleep timer".start()


func movement_animation():
	if Input.is_action_just_pressed("ui_accept") and Global.sleep_meter >0 and !sleeping:
		attacking=true
		$sword_slash.play()
		Global.sleep_meter -=1
		$"attack timer".start(0.6)
	if attacking:
		if right:
			$AnimationPlayer.play("attack right")
		else:
			$AnimationPlayer.play("attack left")
	else:
		if velocity.x>0:
			right=true
			$AnimationPlayer.play("move right ")
		elif velocity.x<0:
			right=false
			$AnimationPlayer.play("move left")
		else:
			if right:
				$AnimationPlayer.play("idle")
			else:
				$AnimationPlayer.play("idle left ")
		if velocity.y<0:
			if right:
				$AnimationPlayer.play("jump")
			else:
				$AnimationPlayer.play("jump left ")
		elif velocity.y>0:
			if right:
				$AnimationPlayer.play("fall ")
			else:
				$AnimationPlayer.play("fall left")


func _on_attack_timer_timeout():
	attacking=false


func _on_death_timer_timeout():
	get_tree().change_scene_to_file("res://game_over.tscn")


func _on_bed_detection_area_entered(area):
	$bed_detection/Label.visible = true
	sleep_option= true



func _on_bed_detection_area_exited(area):
	$bed_detection/Label.visible = false
	sleep_option = false


func _on_sleep_timer_timeout():
	sleeping = false
	Global.sleep_meter = 5
	if Global.player_health<3:
		Global.player_health+=1





func _on_invinsible_timer_timeout():
	invinsible=false


func _on_hurtbox_area_entered(area):
	if !invinsible:
		$hurt.play()
		$effects.play("player is hit")
		if Global.player_health>0:
			Global.player_health -=1
			invinsible=true
			$"invinsible timer".start(3)
		if Global.player_health <=0:
			$AnimationPlayer.play("death")
			dead=true
			$"death timer".start(1)
