extends AnimatedSprite2D

@onready var _silhouette_sprite: AnimatedSprite2D = $SilhouetteSprite

func _ready() -> void:
	# Ensure silhouette sprite uses the same SpriteFrames resource
	_silhouette_sprite.sprite_frames = sprite_frames
	# Copy other properties
	_silhouette_sprite.offset = offset
	_silhouette_sprite.flip_h = flip_h
	_silhouette_sprite.animation = animation
	_silhouette_sprite.frame = frame

func _process(delta: float) -> void:
	# Continuously sync the silhouette sprite with the main sprite
	if is_instance_valid(_silhouette_sprite):
		_silhouette_sprite.animation = animation  # Update animation
		_silhouette_sprite.frame = frame          # Sync frame
		_silhouette_sprite.flip_h = flip_h        # Sync horizontal flip
		_silhouette_sprite.offset = offset        # Sync offset
