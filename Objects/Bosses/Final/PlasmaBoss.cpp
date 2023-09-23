
#include "S1Engine.hpp"
#include <cstdint>

#define _DEBUG_

#include "Debugger.hpp"
#include "Utils.hpp"
#include "PlasmaBoss.hpp"
#include "PlasmaBall.hpp"

extern uint8_t Map_PLaunch[];
extern uint8_t Ani_PLaunch[];

extern uint16_t v_framecount;

const Vector2_W ObjPlasmaBoss::cameraBase = {
	.x = 0x23E0,
	.y = 0x0580,
};

void ObjPlasmaBoss::execute() {
	switch (routine_id) {
	case ObjPlasmaBoss::Action::init:
		render_bits = 0x04;
		art = 0x300;
		maps = Map_PLaunch;
		sprite_layer = 3;
		routine_id++;
		anim_id = 1;
		setAction(enterRight);
		//fallthrough

	case ObjPlasmaBoss::Action::enterRight:
		action01_EnterRight();
		goto display;

	case ObjPlasmaBoss::Action::attractBalls:
		action02_AttractBalls();
		goto display;

	case ObjPlasmaBoss::Action::verticalAttack:
		action03_VerticalAttack();
		goto display;

	display:
		animateSprite__cdecl(this, Ani_PLaunch);
		displaySprite__cdecl(this);
	}
}

void ObjPlasmaBoss::action01_EnterRight() {
	switch (subroutine_id) {
	case 0x00:
		anim_id = 0;
		position.x = cameraBase.x + 320+0x20;
		position.y = cameraBase.y + 0x20;
		velocity.xf = -0xC0;
		subroutine_id++;
		//fallthrough
	case 0x01:
		{
			const auto targetX = cameraBase.x + 320-0x20;
			speedToPos();
			if (position.x <= targetX) {
				position.x = targetX;
				velocity.xf = 0;
				setAction(attractBalls);
			}
		}
	}
}

void ObjPlasmaBoss::action02_AttractBalls() {
	switch (subroutine_id) {
	case 0x00:
		anim_id = 1;		// use charging animation
		timer = 3 * 60;
		subroutine_id++;
		// fallthrough

	case 0x01:
		// Generate balls
		if (timer > 90 && (v_framecount & 0x3) == 0) {
			auto plasmaBall = create_ObjPlasmaBall(this, ObjPlasmaBall::Subtype::attractedToParent);
			if (plasmaBall) {
				const uint8_t angle = randomNumber__cdecl();
				const int16_t sin = calcSine__cdecl(angle);
				const int16_t cos = calcSine__cdecl(angle + 0x40);

				plasmaBall->position.xf = position.xf + cos * (int32_t)0x18000;    //screenX < 320/2 ? camera->x + 0x20 : camera->x + 320 - 0x20;
				plasmaBall->position.yf = position.yf + sin * (int32_t)0x18000;    //screenX < 320/2 ? camera->x + 0x20 : camera->x + 320 - 0x20;
			}
		}

		timer -= 1;
		if (!timer) {
			Debug::kwrite("Timer expired\xE0");
			setAction(verticalAttack);
		}
		break;
	}
}


void ObjPlasmaBoss::action03_VerticalAttack() {
	switch (subroutine_id) {
	case 0x00:
		anim_id = 0;		// use normal animation
		targetYPos = cameraBase.y + 0x60 + (randomNumber__cdecl() % 2) * 0x20;
		velocity.yf = targetYPos > position.y ? 0x100 : -0x100;
		timer = 60;
		subroutine_id++;
		// fallthrough

	case 0x01:
		// Move to target position
		if (position.y != targetYPos) {
			speedToPos();
		}
		// Stop moving and wait
		else if (timer) {
			timer--;
			velocity.yf = 0;
		}
		// Generate a wall of plasma balls
		else {
			anim_id = 1;	// use charging animation

			// Generate balls above
			for (int16_t ballY = targetYPos - 0x18*2; ballY >= cameraBase.y; ballY -= 0x18) {
				auto plasmaBall = create_ObjPlasmaBall(this, ObjPlasmaBall::Subtype::verticalAttack);
				if (plasmaBall) {
					plasmaBall->position = position;
					plasmaBall->startPos = position.y;
					plasmaBall->targetPos = ballY;
				}
			}
			// Generate balls below
			for (int16_t ballY = targetYPos + 0x18*2; ballY <= cameraBase.y + 0x40 + 4 * 0x20; ballY += 0x18) {
				auto plasmaBall = create_ObjPlasmaBall(this, ObjPlasmaBall::Subtype::verticalAttack);
				if (plasmaBall) {
					plasmaBall->position = position;
					plasmaBall->startPos = position.y;
					plasmaBall->targetPos = ballY;
				}
			}
			timer = 120;
			subroutine_id++;
		}
		break;

	case 0x02:
		if (!--timer) {
			subroutine_id = 0;
		}
		break;

	}
}



void ObjPlasmaBoss::setAction(Action action) {
	routine_id = action;
	subroutine_id = 0;
}

void execute_ObjPlasmaBoss(ObjPlasmaBoss & obj) {
	obj.execute();
}
