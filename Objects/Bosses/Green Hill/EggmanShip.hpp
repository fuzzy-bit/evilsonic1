
#pragma once

#include "S1Engine.hpp"

#include <cstdint>

/* Eggman ship extends in-level object (class inheritance in my Sonic 1?! WHAT THE FUCK?!) */
struct ObjEggmanShip : public LevelObject {

	/* WARNING! Fragile! Don't swap these variables unless you know what you're doing */
	uint8_t scriptId;			/* 0x28 */
	uint8_t scriptRoutineId;
	uint8_t flash_timer;		/* 0x2A */
	uint8_t throwCooldown;

	typedef LevelObject* (*objectGenerator)(LevelObject*);

	void executeMasterScript();
	void handleDamage();
	void throwObject(objectGenerator);
	void script00_TestSeq();
};

/* Use C-style exports to avoid name mangling */
extern "C" void executeMasterScript_ObjEggmanShip(ObjEggmanShip & obj);
