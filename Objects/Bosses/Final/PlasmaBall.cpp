
#define _DEBUG_

#include "Debugger.hpp"
#include "PlasmaBall.hpp"
#include "S1Engine.hpp"
#include "Utils.hpp"

extern uint8_t Map_Plasma[];
extern uint8_t Ani_Plasma[];
extern uint16_t v_framecount;

void ObjPlasmaBall::execute() {
	switch (routine_id) {
	case 0x00:
		render_bits = 0x84;
		art = 0x2300;
		maps = Map_Plasma;
		anim_id = 0;
		sprite_layer = 3;
		routine_id = subtype;
		break;

	case ObjPlasmaBall::Subtype::attractedToParent:
		position.xf += (parent->position.xf - position.xf) / 16;
		position.yf += (parent->position.yf - position.yf) / 16;

		// Delete object upon reaching parent's position
		if (abs(position.x - parent->position.x) <= 2) {
			deleteObject__cdecl(this);
			return;
		}
		goto display;

	case ObjPlasmaBall::Subtype::verticalAttack:
		// Move towards target
		if (interpolation < 0x100) {
			position.yf = (((int32_t)startPos) << 16) + (((int32_t)(targetPos - startPos) * interpolation) << 8);
			interpolation += 0x4;

			// Make balls hostile =C
			if (interpolation >= 0x100) {
				timer = timer ? timer : 30;
				collision_flag = 0x9A;
				anim_id = 1;
				interpolation = 0x100;
			}
		}
		// Wait ...
		else if (timer) {
			timer--;
		}
		// Shoot
		else {
			// Moving left
			if (status_bits & 1) {
				if (velocity.xf < 0x400) {
					velocity.xf += 0xC;
				}
			}
			// Moving right
			else {
				if (velocity.xf > -0x400) {
					velocity.xf -= 0xC;
				}
			}
			speedToPos();
		}
		goto display2;

	case ObjPlasmaBall::Subtype::particleMove:
		speedToPos();
		goto display2;

	case ObjPlasmaBall::Subtype::fallingAttack:
		// Make balls hostile >=C
		if (velocity.yf == 0) {
			velocity.yf = 0x180;
			anim_id = 1;
			collision_flag = 0x9A;
			anim_id = 1;
		}

		speedToPos();

		// Delete upon going past bottom boundary
		{
			const auto camera = getFGCamera();
			const int16_t screenY = position.y - camera->y;

			if (screenY > 224 + 0x18) {
				deleteObject__cdecl(this);
				return;
			}
		}

		goto display;

	display2:
		// Delete when out of screen
		if (!(render_bits & 0x80)) {
			deleteObject__cdecl(this);
			return;
		}

	display:
		animateSprite__cdecl(this, Ani_Plasma);
		displaySprite__cdecl(this);
	}
}

void execute_ObjPlasmaBall(ObjPlasmaBall &obj) {
	obj.execute();
}

ObjPlasmaBall * create_ObjPlasmaBall(LevelObject * parent, ObjPlasmaBall::Subtype subtype) {
	ObjPlasmaBall* plasmaBall = static_cast<ObjPlasmaBall*>(
		createCppObject__cdecl(parent, reinterpret_cast<objectExecuteCallback>(execute_ObjPlasmaBall))
	);
	if (plasmaBall) {
		plasmaBall->parent = parent;
		plasmaBall->subtype = subtype;
	}
	return plasmaBall;
}
