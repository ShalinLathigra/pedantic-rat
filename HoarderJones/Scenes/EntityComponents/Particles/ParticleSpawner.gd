extends Node2D

@export var particle_scene: PackedScene

func _ready() -> void:
	assert(particle_scene)
func emit() -> void:
	var new_particles = particle_scene.instantiate() as GPUParticles2D
	new_particles.global_position = global_position
	get_tree().root.add_child(new_particles)
