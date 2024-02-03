InputBuffer is a class handling inputs for this script. Its main purpose is to block diagonal movement.

PIXEL_INTERVAL is a variable handling how many pixels your player will move each input.
As a distinction, SPEED is how many pixels your player will move each frame.

current_movement_dir is the direction your player is moving.
facing_dir is the direction your player is *facing*. This variable is used for sprite manipulation while the above is
used for directions.

true_position is strange naming by me, I'll concur, but it is basically the position the player needs to be in after each input.

The signal functions (on_detector_xxxx_body_entered/exited) are meant to be connected to certain colliders surrounding the player.
You will probably have to delete them and regenerate them by creating the above-mentioned colliders.

  (3)
(2)O (0)
  (1)

The O is the player, and the parenthesized numbers are the colliders. Please arrange it in that way.

The numbering is quite important. Remember, 
- 0 = right
- 1 = down
- 2 = left
- 3 = up

Remember this when setting the values of the _dir_collisions_bit_array. true if a collider enters, false if otherwise.

The script does not have a framework in place for animations yet. Sorry about that.

