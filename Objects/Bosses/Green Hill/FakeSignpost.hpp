
#include "S1Engine.hpp"

struct ObjFakeSignpost : public LevelObject {
	static const int8_t sparkleData[];
	int16_t spintime;
	int16_t sparkletime;
	uint16_t sparkle_pos;

	void execute();
};

extern "C" void execute_ObjFakeSignpost(ObjFakeSignpost & obj);
