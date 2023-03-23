# S1 Engine Test
Known issues:
- Music can be weird, experimental sound driver
- Sound test is broken
- Songs are in a weird order
- Music fades out when it's supposed to stop, and vice versa
- Not all title cards are replaced
- Roller graphics are incorrect, displays Caterkiller art when rolling.

Respawn Issues:
- Sprite priority is not reset on respawn
- Camera or tiles act up on respawn
- Level events get triggered again after death
- Drowning softlocks the game, doesn't restart level music
- Speed shoes' music modifier applies only after the effect wears off
- Ring counter doesn't get updated after death
- Objects sometimes do not re-appear upon respawning until you move the camera away
- Dying with invincibility does not reset the music, only the state

Clear object RAM and whatnot on respawn, and find a way to undo level events.

# Credits
- Code: Fuzzy, Vladikcomper, Varion, Rivet, VladislavSavvateev
- Music: Jet, Vladikcomper
- MegaPCM + VEPS Sound Driver: Vladikcomper
- 32X Assistance: Varion
- Levels: Fuzzy
- Original Game: SEGA, Sonic Team