
#pragma once

#include "S1Engine.hpp"

#include <cstdint>

struct ObjGHZBossEggmanMonitor : public LevelObject {
	bool landedOnFloor;
	bool isBroken;
	uint8_t explosionTimer;

	void execute();
};

extern "C" void execute_ObjGHZBossEggmanMonitor(ObjGHZBossEggmanMonitor & obj);
