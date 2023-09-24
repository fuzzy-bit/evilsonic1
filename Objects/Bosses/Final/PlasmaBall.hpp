
#pragma once

#include "S1Engine.hpp"

struct ObjPlasmaBall : public LevelObject {
	enum Subtype {
		attractedToParent = 1,
		verticalAttack,
		particleMove,
		fallingAttack,
	};

	Subtype subtype;
	LevelObject * parent;
	int16_t startPos;
	int16_t targetPos;
	int16_t interpolation;
	int16_t timer;

	void execute();
};

extern "C" void execute_ObjPlasmaBall(ObjPlasmaBall & obj);

extern "C" ObjPlasmaBall * create_ObjPlasmaBall(LevelObject * parent, ObjPlasmaBall::Subtype subtype);
