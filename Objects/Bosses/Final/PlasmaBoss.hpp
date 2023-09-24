
#include "S1Engine.hpp"

struct ObjPlasmaBoss : public LevelObject {
	static const Vector2_W cameraBase;
	static const uint8_t actionScript[];
	enum Action {
		init = 0,
		enterRight = 1,
		attractBalls,
		verticalAttack,
		changePosition,
		enterLeft,
	};
	enum ActionScriptFlag {
		jumpTo = 0x80,
		jumpIfHealthAbove,	// args: health, position
		jumpWithProbability,
	};

	uint16_t timer;
	int16_t targetYPos;
	uint8_t flash_timer;
	uint8_t actionScriptPos;

	void execute();
	void handleDamage();
	void setAction(Action action);
	void setNextActionFromScript();
	void action01_EnterRight();
	void action02_AttractBalls();
	void action03_VerticalAttack();
	void action04_ChangePosition();
	void action05_EnterLeft();

	inline void verticalAttack_MakeBall(int16_t targetY, bool isLeft);
};

extern "C" void execute_ObjPlasmaBoss(ObjPlasmaBoss & obj);
