
#include <cstddef>
#include <cstdint>

#include "S1Engine.hpp"
#include "EggmanShip.hpp"
#include "EggmanMonitor.hpp"
#include "SpikedBall.hpp"

extern "C" LevelObject * BGHZ_CreateSpikedBall__cdecl(LevelObject * parent);
extern "C" LevelObject * BGHZ_CreateEggmanMonitor__cdecl(LevelObject * parent);

/* Entry point for Eggman ship's master script */
void ObjEggmanShip::executeMasterScript() {
	switch (scriptId) {
	case 0x00:
		script00_TestSeq();
		break;

	default:
		/* Using incorrect master script routine is illegal */
		asm("illegal");
	}

	handleDamage();
	speedToPos();
};

void ObjEggmanShip::handleDamage() {
	if (!collision_flag) {
		if (!flash_timer) {
			flash_timer = 0x21;
			playSound__cdecl(0xAC);	// play boss damage sound
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

void ObjEggmanShip::script00_TestSeq() {
	switch (scriptRoutineId) {
	case 0x00:
		{
			const auto camera = getFGCamera();

			// Position pre-requisites
			position.x = camera->x + 320/2 + 0x30;
			position.y = camera->y + 224/2 - 0x50;
			velocity.xf = 0x300;

			status_bits |= 1;	// turn right
			health = 255;		// ###
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

			// Throw shit if within range
			if (throwCooldown) {
				throwCooldown--;
			}
			if (!throwCooldown 
				&& (screenX > 200) && (screenX < 200 + 75) && (screenY > 32) && (screenY < 32 + 45)
			) {
				#pragma GCC diagnostic push
				#pragma GCC diagnostic ignored "-Wcast-function-type"
				throwObject(
					randomNumber__cdecl() & 1 
						? reinterpret_cast<objectExecuteCallback>(execute_ObjGHZBossEggmanMonitor)
						: reinterpret_cast<objectExecuteCallback>(execute_ObjGHZBossSpikedBall)
				);
				#pragma GCC diagnostic pop
				throwCooldown = 90;
			}

			break;
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
