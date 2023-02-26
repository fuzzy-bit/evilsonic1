# S1 Engine Test
Known issues:
- Sprite priority is not reset on respawn
- Music can be weird, experimental sound driver
- Camera or tiles act up on respawn
- Level events get triggered again after death
- Sound test is broken
- Drowning softlocks the game, doesn't restart level music
- Songs are in a weird order
- Music fades out when it's supposed to stop, and vice versa
- Speed shoes' music modifier applies only after the effect wears off
- Not all title cards are replaced
- Ring counter doesn't get updated after death
- Objects sometimes do not re-appear upon respawning until you move the camera away
- Dying with invincibility does not reset the music, only the state

Clear object RAM and whatnot on respawn, and find a way to undo level events.