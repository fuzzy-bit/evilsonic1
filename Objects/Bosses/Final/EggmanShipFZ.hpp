
#pragma once

#include "S1Engine.hpp"

#include <cstdint>

/* Eggman ship extends in-level object (class inheritance in my Sonic 1?! WHAT THE FUCK?!) */
struct ObjEggmanShipFZ : public LevelObject {
	static const Vector2_W cameraBase;

	/* WARNING! Fragile! Don't swap these variables unless you know what you're doing */
	uint8_t scriptId;			/* 0x28 */
	uint8_t scriptRoutineId;
	uint8_t flash_timer;		/* 0x2A */
	uint8_t genericCounter;
	bool forceLaugh;			/* 0x2C */

	void executeMasterScript();
	void handleDamage();
	void generateProjectiles();

	void script00_Intro();
	void script01_Attack();
	void script02_Defeated();
};

/* Use C-style exports to avoid name mangling */
extern "C" void executeMasterScript_ObjEggmanShipFZ(ObjEggmanShipFZ & obj);
