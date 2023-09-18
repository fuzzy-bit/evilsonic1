
#include "EggmanShip.hpp"
#include "Engine.hpp"

/* Entry point for Eggman ship's master script */
void ObjEggmanShip::executeMasterScript() {
	switch (scriptId) {
	case 0x00:
		script00_TestSeq();
		break;

	default:
		/* Using incorrect master script routine is illegal */
		asm("illegal");
	}

	speedToPos();
};

void ObjEggmanShip::script00_TestSeq() {
	switch (scriptRoutineId) {
	case 0x00:
		{
			const auto camera = getFGCamera();
			position.x = camera->x + 320/2 + 0x40;
			position.y = camera->y + 224/2 + 0x40;
			scriptRoutineId++;
		}
		// fallthrough

	case 0x01:
		// Hover up trajectory
		{
			const auto camera = getFGCamera();
			const auto screenX = position.x - camera->x;
			const auto screenY = position.y - camera->y;

			if (screenX < 320/2 + 0x20) {
				velocity.xf += 0x20;
			}
			else if (screenX > 320/2 + 0x30) {
				velocity.xf -= 0x8;
			}

			if (screenY > 0x30) {
				velocity.yf -= 0x18;
			}
			else if (screenY < 0x20) {
				velocity.yf += 0x0C;
			}

			break;
		}
	}
}

/* Proxy C++ class method call for the C API */
void executeMasterScript_ObjEggmanShip(ObjEggmanShip & obj) {
	obj.executeMasterScript();
}
