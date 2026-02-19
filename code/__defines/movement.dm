#define HAS_TRANSFORMATION_MOVEMENT_HANDLER(X) X.HasMovementHandler(/datum/movement_handler/mob/transformation)
#define ADD_TRANSFORMATION_MOVEMENT_HANDLER(X) X.AddMovementHandler(/datum/movement_handler/mob/transformation)
#define DEL_TRANSFORMATION_MOVEMENT_HANDLER(X) X.RemoveMovementHandler(/datum/movement_handler/mob/transformation)

#define DELAY2GLIDESIZE(delay) (world.icon_size / max(Ceiling(delay / world.tick_lag), 1))

// Enum for results of is_space_movement_permitted()
#define SPACE_MOVE_SUPPORTED (-1)
#define SPACE_MOVE_FORBIDDEN   0
#define SPACE_MOVE_PERMITTED   1
