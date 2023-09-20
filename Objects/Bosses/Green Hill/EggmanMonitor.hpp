
#pragma once

#include "Engine.hpp"

#include <cstdint>

struct ObjGHZBossEggmanMonitor : public LevelObject {
	bool landedOnFloor;

	void execute();
};

extern "C" void execute_ObjGHZBossEggmanMonitor(ObjGHZBossEggmanMonitor & obj);
