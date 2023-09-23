
#define _DEBUG_

#include <cstdint>

#include "S1Engine.hpp"
#include "Debugger.hpp"

#include "EggmanMonitor.hpp"

extern uint8_t Map_Monitor[];
extern uint8_t Ani_Monitor[];

void ObjGHZBossEggmanMonitor::execute() {
	switch (routine_id) {
	case 0x00: 	// Init
		render_bits = 0x04;
		maps = Map_Monitor;
		art = 0x680;
		visible_width = 0xF;
		collision_flag = 0x46;
		anim_id = 0x01;
		sprite_layer = 6;
		routine_id++;
		//fallthrough

	case 0x01:	// Main
	Main:
		{
			// Physics are supressed during explosion
			if (explosionTimer) {
				explosionTimer -= 1;
			}

			// Normal physics
			else {
				// Bounce off the floor and falling physics
				if (!landedOnFloor) {
					// Air friction
					if (velocity.xf > 0) {	
						velocity.xf -= 0x08;
					}
					velocity.yf += 0x38;	// make me fall
				}
				const auto floorDist = objFloorDist__cdecl(this) - 0x0F;
				if (floorDist <= 0) {
					position.y += floorDist;
					if (!isBroken && velocity.yf > 0x100) {
						velocity.yf = -velocity.yf/2 > -0x400 ? -velocity.yf/2 : 0x400;
					}
					else {
						velocity = { .xf = 0, .yf = 0 };
						landedOnFloor = true;
					}
				}
				speedToPos();
			}

			// Delete when out of view
			const auto camera = getFGCamera();
			const auto screenX = position.x - camera->x;
			if (screenX < -0x18) {
				deleteObject__cdecl(this);
			}
			else {
				animateSprite__cdecl(this, Ani_Monitor);
				displaySprite__cdecl(this);
			}
		}
		break;

	case 0x03:		// BreakOpen
		{
			// Spawn explosion & monitor contents
			LevelObject * explosion = (LevelObject *)findFreeObj__cdecl();
			if (explosion) {
				explosion->id = 0x3F;
				explosion->position = position;
			}
			LevelObject * contents = (LevelObject *)findFreeObj__cdecl();
			if (contents) {
				contents->id = 0x2E;
				contents->position = position;
				contents->anim_id = anim_id;
			}

			explosionTimer = 15;
			velocity.yf = 0x00;
			anim_id = 0x09;			// use broken animation
			collision_flag = 0x00;	// reset collision
			routine_id = 0x01;		// => Main
			isBroken = true;

			goto Main;
		}
	}

}

void execute_ObjGHZBossEggmanMonitor(ObjGHZBossEggmanMonitor & obj) {
	obj.execute();
}
