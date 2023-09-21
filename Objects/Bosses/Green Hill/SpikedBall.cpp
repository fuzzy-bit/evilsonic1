
#include "SpikedBall.hpp"
#include "Engine.hpp"
#include "S1Bindings.hpp"

extern uint8_t Map_SSawBall_internal[];

void ObjGHZBossSpikedBall::execute() {
	switch (routine_id) {
	case 0x00:	// Init
		render_bits = 0x04;
		art = 0xA300 / 0x20;
		maps = Map_SSawBall_internal;
		sprite_layer = 6;
		collision_flag = 0x80 | 0x18;
		routine_id++;	// => Main
		//fallthrough

	case 0x01:	// Main
		{
			velocity.yf += 0x28;	// make me fall
			if (velocity.xf > -0x80) {	// air friction
				velocity.xf -= 0x08;
			}

			// Bounce off the floor
			const auto floorDist = objFloorDist__cdecl(this) - 0x08;
			if (floorDist <= 0) {
				position.y += floorDist;
				velocity.yf = -2*velocity.yf/3 > -0x400 ? -2*velocity.yf/3 : -0x400;
			}

			// Delete when out of view
			const auto camera = getFGCamera();
			const auto screenX = position.x - camera->x;
			if (screenX < -0x8) {
				deleteObject__cdecl(this);
			}
			else {
				speedToPos();
				displaySprite__cdecl(this);
			}
		}
	}
}

void execute_ObjGHZBossSpikedBall(ObjGHZBossSpikedBall & obj) {
	obj.execute();
}
