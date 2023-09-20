
#include <cstdint>

#include "S1Bindings.hpp"
#include "EggmanMonitor.hpp"

extern uint8_t Map_Monitor[];
extern uint8_t Ani_Monitor[];


void ObjGHZBossEggmanMonitor::execute() {

	switch (routine_id) {
	case 0x00: 
		render_bits = 0x04;
		maps = Map_Monitor;
		art = 0x680;
		visible_width = 0xF;
		anim_id = 0x01;
		sprite_layer = 6;
		routine_id++;
		//fallthrough

	case 0x01:
		{
			if (velocity.xf > 0) {	// air friction
				velocity.xf -= 0x08;
			}

			// Bounce off the floor and falling physics
			if (!landedOnFloor) {
				velocity.yf += 0x38;	// make me fall
			}
			const auto floorDist = objFloorDist__cdecl(this) - 0x0F;
			if (floorDist <= 0) {
				position.y += floorDist;
				if (velocity.yf > 0x100) {
					velocity.yf = -velocity.yf/2 > -0x400 ? -velocity.yf/2 : 0x400;
				}
				else {
					velocity.yf = 0;
					landedOnFloor = true;
				}
			}

			// Delete when out of view
			const auto camera = getFGCamera();
			const auto screenX = position.x - camera->x;
			if (screenX < -0x18) {
				deleteObject__cdecl(this);
			}
			else {
				speedToPos();
				animateSprite__cdecl(this, Ani_Monitor);
				displaySprite__cdecl(this);
			}
		}
	}

}

void execute_ObjGHZBossEggmanMonitor(ObjGHZBossEggmanMonitor & obj) {
	obj.execute();
}
