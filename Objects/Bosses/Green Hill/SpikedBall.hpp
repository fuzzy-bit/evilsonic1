
#pragma once

#include "S1Engine.hpp"

#include <cstdint>

struct ObjGHZBossSpikedBall : public LevelObject {
	void execute();
};

extern "C" void execute_ObjGHZBossSpikedBall(ObjGHZBossSpikedBall & obj);
