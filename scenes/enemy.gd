extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var wall_collide = false
var player_position
var target_position 
var blast = false
@onready var player = get_parent().get_parent().get_node("player")

func  _ready():
	$Timer.start()

func _physics_process(delta):
	
	if !blast:
		if velocity.x==0:
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("move")
		if not is_on_floor():
			velocity.y += gravity * delta
		else:
			player_position = player.position
			target_position = (player_position-position).normalized()
			velocity = target_position*SPEED
	
		if wall_collide== true:
			velocity.y = -400
			wall_collide=false
	else:
		if not is_on_floor():
			velocity.y += gravity * delta
		velocity.x = move_toward(velocity.x,0,10)
	move_and_slide()
	if velocity.x>0:
		$AnimatedSprite2D.flip_h =false
	else:
		$AnimatedSprite2D.flip_h =true

func _on_area_2d_body_entered(body):
	wall_collide = true
	




func _on_hurtbox_area_entered(area):
	Global.score +=1
	queue_free()


func _on_player_detection_body_entered(body):
	if !blast:
		blast= true
		$AnimatedSprite2D.play("blast")
		$explosion.play()
		await get_tree().create_timer(1.7).timeout
		queue_free()



func _on_timer_timeout():
	$grawl.play()
