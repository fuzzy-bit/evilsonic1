
#include <cstddef>
#include <cstdint>

#include "S1Engine.hpp"
#include "EggmanShipFZ.hpp"
#include "PlasmaBall.hpp"

extern uint16_t v_framecount;
extern uint8_t v_dle_routine;
extern uint8_t v_shaketimer;

const Vector2_W ObjEggmanShipFZ::cameraBase = {
	.x = 0x23E0,
	.y = 0x0580,
};


/* Entry point for Eggman ship's master script */
void ObjEggmanShipFZ::executeMasterScript() {
	switch (scriptId) {
	case 0x00:
		generateProjectiles();
		script00_Intro();
		goto handleDamageAndMovement;

	case 0x01:
		generateProjectiles();
		script01_Phase1();
		goto handleDamageAndMovement;

	case 0x02:
		generateProjectiles();
		script02_Phase2();
		goto handleDamageAndMovement;

	case 0x03:
		script03_Defeated();
		goto handleMovement;

	handleDamageAndMovement:
		handleDamage();

	handleMovement:
		speedToPos();
		break;

	default:
		/* Using incorrect master script routine is illegal */
		asm("illegal");
	}

};

void ObjEggmanShipFZ::handleDamage() {
	if (!collision_flag) {
		if (!flash_timer) {
			playSound__cdecl(0xAC);	// play boss damage sound
			// Is defeated flag set?
			if (status_bits & 0x80) {
				scriptId = 2;
				scriptRoutineId = 0;
				return;
			}
			flash_timer = 0x21;
		}

		if (--flash_timer) {
			uint16_t * bossBodyColor = (uint16_t*)0xFFFFFB22;
			*bossBodyColor = *bossBodyColor ? 0x000 : 0xEEE;
		}
		else {
			collision_flag = 0xF;	// restore collision
		}
	}
}

void ObjEggmanShipFZ::script00_Intro() {
	switch (scriptRoutineId) {
	case 0x00:
		{
			// Initial position
			position.x = cameraBase.x + 320/2;
			position.y = cameraBase.y + -0x60;
			velocity.yf = 0x140;
			forceLaugh = true;		// we're laughin'

			status_bits |= 1;		// turn right
			health = 0xF;			// we're healthy
			genericCounter = 30;

			scriptRoutineId++;
		}
		// fallthrough

	case 0x01:	// Moving down and preparing take off ...
		{
			// Slowdown trajectory
			const auto screenY = position.y - cameraBase.y;

			if (screenY > 0x10) {
				// Start slowing down
				if (velocity.yf > 0) {
					velocity.yf -= 0x0C;
				}
				// Reached stop point
				else {
					velocity.yf = 0x00;

					// Take off now ...
					if (!genericCounter--) {
						forceLaugh = false;	// we're srs now >=C
						scriptId = 1;
						scriptRoutineId = 0;
					}
				}
			}
		}
		break;
	}
}


void ObjEggmanShipFZ::script01_Phase1() {
	const int16_t targetX = cameraBase.x + 320/2 + calcSine__cdecl(genericCounter++) / 8;
	const int16_t targetY = cameraBase.y + 224/2 - 0x40;

	if (health <= 8) {
		collision_flag = 0x9A;
		scriptRoutineId = 1;
	}

	if (position.x > targetX && velocity.xf > -0x200) {
		velocity.xf -= 0x04;
		status_bits &= -2;
	}
	if (position.x < targetX && velocity.xf < 0x200) {
		velocity.xf += 0x04;
		status_bits |= 1;
	}

	if (position.y > targetY && velocity.yf >= -0x180) {
		velocity.yf -= 0x02;
	}
	if (position.y < targetY && velocity.yf <= 0x100) {
		velocity.yf += 0x02;
	}

	speedToPos();
}


void ObjEggmanShipFZ::script02_Phase2() {
	script01_Phase1()
}


void ObjEggmanShipFZ::script03_Defeated() {
	switch (scriptRoutineId) {
	case 0x00:
		genericCounter = 180;
		velocity = { .xf = 0, .yf = 0 };
		forceLaugh = false;	// no time for laughin'
		scriptRoutineId++;
		// fallthrough

	case 0x01:
		// Boss defeated sequence
		if ((v_framecount & 3) == 0) {
			LevelObject * explosion = static_cast<LevelObject*>(findFreeObj__cdecl());
			if (explosion) {
				explosion->id = 0x3F;
				explosion->position = position;
				explosion->position.x += ((randomNumber__cdecl() & 0xFF) >> 2) - 0x20;
				explosion->position.y += ((randomNumber__cdecl() & 0xFF) >> 3);
			}
		}
		// Wait before fall
		if (genericCounter) {
			if (!--genericCounter) {
				velocity.yf += 0x18;
			}
		}
		// Fall
		else if (velocity.yf) {
			if (velocity.yf < 0x300) {
				velocity.yf += 0x18;
			}
			if (position.y > cameraBase.y + 224 + 0x60) {
				scriptRoutineId++;
			}
			speedToPos();
		}
		break;

	case 0x02:		// We're done here!
		// Too tired to handle boss deletion right now, so we'll just hide it
		position.x = 0;
		position.y = 0;

		playSound__cdecl(0xE0);		// fade out sound
		v_dle_routine += 2;
		scriptRoutineId++;
	}
}

void ObjEggmanShipFZ::generateProjectiles() {
	if ((v_framecount & 0x2F) == 0) {
		auto plasmaBall = create_ObjPlasmaBall(this, ObjPlasmaBall::fallingAttack);
		if (plasmaBall) {
			plasmaBall->position.x = cameraBase.x + 0x10 + (randomNumber__cdecl() & 7) * 0x27;
			plasmaBall->position.y = cameraBase.y - 0x18;
		}

		LevelObject * explosion = static_cast<LevelObject*>(findFreeObj__cdecl());
		if (explosion && plasmaBall) {
			explosion->id = 0x3F;
			explosion->position.x = plasmaBall->position.x;
			explosion->position.y = plasmaBall->position.y + 0x18;
		}
	}
	else if ((v_framecount & 0x1F) == 0) {
		v_shaketimer = 8;
	}
}

/* Proxy C++ class method call for the C API */
void executeMasterScript_ObjEggmanShipFZ(ObjEggmanShipFZ & obj) {
	obj.executeMasterScript();
}
