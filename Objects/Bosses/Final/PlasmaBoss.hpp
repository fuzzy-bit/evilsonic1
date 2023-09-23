
#include "S1Engine.hpp"

struct ObjPlasmaBoss : public LevelObject {
	static const Vector2_W cameraBase;
	enum Action {
		init = 0,
		enterRight = 1,
		attractBalls,
		verticalAttack,
	};

	uint16_t timer;
	int16_t targetYPos;

	void execute();
	void setAction(Action action);
	void action01_EnterRight();
	void action02_AttractBalls();
	void action03_VerticalAttack();
};

extern "C" void execute_ObjPlasmaBoss(ObjPlasmaBoss & obj);
