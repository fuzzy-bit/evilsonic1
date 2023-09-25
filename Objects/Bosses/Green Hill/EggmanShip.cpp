
#include <cstddef>
#include <cstdint>

#include "S1Engine.hpp"
#include "EggmanShip.hpp"
#include "EggmanMonitor.hpp"
#include "SpikedBall.hpp"

extern uint16_t v_framecount;
extern uint8_t f_timecount;
extern uint8_t v_dle_routine;

/* Entry point for Eggman ship's master script */
void ObjEggmanShip::executeMasterScript() {
	switch (scriptId) {
	case 0x00:
		script00_Intro();
		goto handleDamageAndMovement;

	case 0x01:
		script01_ThrowSequence();
		goto handleDamageAndMovement;

	case 0x02:
		script02_Defeated();
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

void ObjEggmanShip::handleDamage() {
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

void ObjEggmanShip::script00_Intro() {
	const auto camera = getFGCamera();

	switch (scriptRoutineId) {
	case 0x00:
		{
			// Initial position
			position.x = camera->x + 320/2;
			position.y = camera->y + -0x40;
			velocity.yf = 0x200;
			forceLaugh = true;		// we're laughin'

			status_bits |= 1;		// turn right
			health = 10;			// we're healthy
			throwCooldown = 30;

			scriptRoutineId++;
		}
		// fallthrough

	case 0x01:	// Moving down and preparing take off ...
		{
			// Slowdown trajectory
			const auto screenY = position.y - camera->y;

			if (screenY > 0x10) {
				// Start slowing down
				if (velocity.yf > 0) {
					velocity.yf -= 0x0C;
				}
				// Reached stop point
				else {
					velocity.yf = 0x00;

					// Take off now ...
					if (!throwCooldown--) {
						forceLaugh = false;	// we're srs now >=C
						velocity.xf = -0x200;
						velocity.yf = 0x180;
						scriptRoutineId++;
					}
				}
			}
		}
		break;

	case 0x02:	// Fly away now! Fly away!
		{
			// Take off trajectory
			if (velocity.xf < 0x400) {
				velocity.xf += 0x18;
			}
			if (velocity.yf > -0x200) {
				velocity.yf -= 0x08;
			}

			// Start scrolling shit ...
			const auto screenX = position.x - camera->x;
			if (screenX > 320 - 0x40) {
				v_dle_routine += 2;	// start scrolling shit...
				f_timecount = 1;	// start timer...
				playSound__cdecl(0x8C);
				throwCooldown = 60;
				scriptRoutineId++;
			}
		}
		break;

	case 0x03:	// Reaching entry point for script01 ...
		{
			// Wait
			if (throwCooldown) {
				throwCooldown--;
				return;
			}

			const auto camera = getFGCamera();
			const auto targetX = camera->x + 320/2 + 0x30;
			const auto targetY = camera->y + 224/2 - 0x50;

			// Reach target Y
			if (position.y > targetY) {
				velocity.yf = (velocity.yf > -0x200) ? velocity.yf - 0x04 : velocity.yf;
			}
			else if (position.y < targetY) {
				velocity.yf = (velocity.yf < 0x200) ? velocity.yf + 0x04 : velocity.yf;
			}
			else {
				velocity.yf = 0;
			}

			// Reach target X
			if (position.x > targetX) {
				velocity.xf = (velocity.xf > 0x240) ? velocity.xf - 0x0C : velocity.xf;
			}
			else if (position.x < targetX) {
				velocity.xf = (velocity.xf < 0x500) ? velocity.xf + 0x0C : velocity.xf;
			}
			else {
				velocity.xf = 0x300;
			}

			if (position.y == targetY && position.x == targetX && velocity.xf == 0x300 && velocity.yf == 0) {
				scriptId = 1;
				scriptRoutineId = 0;
			}
		}
		break;
	}
}

void ObjEggmanShip::script01_ThrowSequence() {
	switch (scriptRoutineId) {
	case 0x00:
		{
			const auto camera = getFGCamera();

			// Position pre-requisites
			position.x = camera->x + 320/2 + 0x30;
			position.y = camera->y + 224/2 - 0x50;
			velocity.xf = 0x300;

			scriptRoutineId++;
		}
		// fallthrough

	case 0x01:
		{
			// Hover up trajectory
			const auto camera = getFGCamera();
			const auto screenX = position.x - camera->x;
			const auto screenY = position.y - camera->y;

			// Move left-right, slightly tilt up-down
			if (screenX < 320/2 + 0x50) {
				velocity.xf += 0x08/4;
				velocity.yf -= 0x01;
			}
			else {
				velocity.xf -= 0x04/4;
				velocity.yf += 0x01;
			}

			// Stay within bounds on Y-axis
			if (screenY > 224/2 - 0x48 && velocity.yf > 0) {
				velocity.yf -= 0x06;
			}
			else if (screenY < 224/2 - 0x64 && velocity.yf < 0) {
				velocity.yf += 0x08;
			}

			// Don't throw shit during first few hits
			if (health > 8) {
				return;
			}

			// Throw shit if within range
			if (throwCooldown) {
				throwCooldown--;
				if (throwCooldown == 90) {
					#pragma GCC diagnostic push
					#pragma GCC diagnostic ignored "-Wcast-function-type"
					throwObject(
						randomNumber__cdecl() & 1 
							? reinterpret_cast<objectExecuteCallback>(execute_ObjGHZBossEggmanMonitor)
							: reinterpret_cast<objectExecuteCallback>(execute_ObjGHZBossSpikedBall)
					);
					#pragma GCC diagnostic pop
				}
				else if (throwCooldown == 60) {
					forceLaugh = false;
				}
			}
			if (!throwCooldown 
				&& (screenX > 200) && (screenX < 200 + 75) && (screenY > 32) && (screenY < 32 + 45)
			) {
				// About to throw an object
				throwCooldown = 120;
				forceLaugh = true;
			}

			break;
		}
	}
}

void ObjEggmanShip::script02_Defeated() {
	switch (scriptRoutineId) {
	case 0x00:
		throwCooldown = 180;
		forceLaugh = false;	// no time for laughin'
		scriptRoutineId++;
		// fallthrough

	case 0x01:
		{

			const auto camera = getFGCamera();
			const auto targetX = camera->x + 320/2;
			const auto targetY = camera->y + 224/2 - 0x50;

			if (position.x > targetX) {
				velocity.xf = velocity.xf > 0x100 ? velocity.xf -= 0x0E : velocity.xf;
			}
			else {
				velocity.xf = velocity.xf < 0x400 ? velocity.xf += 0x0E : velocity.xf;
			}

			if (position.y > targetY) {
				velocity.yf = velocity.yf > -0x100 ? velocity.yf -= 0x04 : velocity.yf;
			}
			else {
				velocity.yf = velocity.yf < 0x100 ? velocity.yf += 0x04 : velocity.yf;
			}

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
		}
		// Prepare to fly away
		if (!throwCooldown--) {
			throwCooldown = 120;
			velocity.xf = 0x100;
			velocity.yf = 0x300;

			scriptRoutineId++;
		}
		break;

	case 0x02:		// Flying away
		velocity.xf += 0x20;
		velocity.yf -= 0x12;

		// We're done here
		if (!throwCooldown--) {
			// Too tired to handle boss deletion right now, so we'll just hide it
			position.x = 0;
			position.y = 0;

			playSound__cdecl(0x81);
			v_dle_routine += 2;
			scriptRoutineId++;
		}
	}
}

void ObjEggmanShip::throwObject(objectExecuteCallback executeCallback) {
	LevelObject * thrownObject = createCppObject__cdecl(this, executeCallback);
	if (thrownObject != nullptr) {
		thrownObject->velocity = velocity;	// transfer velocity vector
		thrownObject->position = position;	// transfer position vector
	}
}

/* Proxy C++ class method call for the C API */
void executeMasterScript_ObjEggmanShip(ObjEggmanShip & obj) {
	obj.executeMasterScript();
}
