
#pragma once

#include "Engine.hpp"

#include <cstdint>

struct ObjGHZBossSpikedBall : public LevelObject {
	void execute();
};

extern "C" void execute_ObjGHZBossSpikedBall(ObjGHZBossSpikedBall & obj);
