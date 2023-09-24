
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
extern LevelObject v_player;

const Vector2_W ObjPlasmaBoss::cameraBase = {
	.x = 0x23E0,
	.y = 0x0580,
};

const uint8_t ObjPlasmaBoss::actionScript[] = {
	ObjPlasmaBoss::Action::enterRight,		// 0
	ObjPlasmaBoss::Action::attractBalls,	// 1

	ObjPlasmaBoss::Action::verticalAttack,	// 2
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalAttack,

	ObjPlasmaBoss::ActionScriptFlag::jumpIfHealthAbove, 10, 2,

	ObjPlasmaBoss::Action::changePosition,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::changePosition,
	ObjPlasmaBoss::ActionScriptFlag::jumpTo, 2
};

void ObjPlasmaBoss::execute() {
	switch (routine_id) {
	case ObjPlasmaBoss::Action::init:
		Debug::kwrite("Initializing...\xE0");
		render_bits = 0x04;
		art = 0x300;
		maps = Map_PLaunch;
		sprite_layer = 3;
		anim_id = 1;
		collision_flag = 0xB;
		health = 16;
		setNextActionFromScript();
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

	case ObjPlasmaBoss::Action::changePosition:
		action04_ChangePosition();
		goto display;

	case ObjPlasmaBoss::Action::enterLeft:
		action05_EnterLeft();
		goto display;

	display:
		handleDamage();
		animateSprite__cdecl(this, Ani_PLaunch);
		if (!(flash_timer & 1)) {
			displaySprite__cdecl(this);
		}
	}
}

void ObjPlasmaBoss::setNextActionFromScript() {
fetchScriptByte:
	const uint8_t script_byte = actionScript[actionScriptPos++];

	// Is `script_byte` an action?
	if (script_byte < 0x80) {
		Debug::kwrite("Setting action from script: pos=\x80, action=\x80\xE0", actionScriptPos-1, script_byte);
		setAction(static_cast<Action>(script_byte));
	}
	// Script byte is a flag ...
	else {
		switch (script_byte) {
		case ActionScriptFlag::jumpTo:
			actionScriptPos = actionScript[actionScriptPos++];
			goto fetchScriptByte;

		case ActionScriptFlag::jumpIfHealthAbove:
			if (health > actionScript[actionScriptPos++]) {
				actionScriptPos = actionScript[actionScriptPos++];
				goto fetchScriptByte;
			}
			else {
				actionScriptPos++;
				goto fetchScriptByte;
			}
			break;

		default:
			Debug::raiseError("Unknown action script flag");
		}
	}
}

void ObjPlasmaBoss::handleDamage() {
	if (!collision_flag) {
		if (!flash_timer) {
			// First frame of damage: Help Sonic bounce off the boss
			if (v_player.position.x < position.x && v_player.velocity.xf > -0x200) {
				v_player.velocity.xf = -0x200;
			}
			else if (v_player.position.x > position.x && v_player.velocity.xf < 0x200) {
				v_player.velocity.xf = 0x200;
			}

			flash_timer = 0x21;
			playSound__cdecl(0xAC);	// play boss damage sound
		}

		if (!--flash_timer) {
			collision_flag = 0xB;	// restore collision
		}
	}
}

void ObjPlasmaBoss::action01_EnterRight() {
	switch (subroutine_id) {
	case 0x00:
		anim_id = 0;
		render_bits &= -2;
		status_bits &= -2;
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
				setNextActionFromScript();
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
			setNextActionFromScript();
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

			const bool isLeft = position.x - cameraBase.x < 160;
			// Generate balls above
			for (int16_t ballY = targetYPos - 0x18*2; ballY >= cameraBase.y; ballY -= 0x18) {
				verticalAttack_MakeBall(ballY, isLeft);
			}
			// Generate balls below
			for (int16_t ballY = targetYPos + 0x18*2; ballY <= cameraBase.y + 0x40 + 4 * 0x20; ballY += 0x18) {
				verticalAttack_MakeBall(ballY, isLeft);
			}
			timer = 120;
			subroutine_id++;
		}
		break;

	case 0x02:
		if (!--timer) {
			setNextActionFromScript();
		}
		break;
	}
}

inline void ObjPlasmaBoss::verticalAttack_MakeBall(int16_t targetY, bool isLeft) {
	auto plasmaBall = create_ObjPlasmaBall(this, ObjPlasmaBall::Subtype::verticalAttack);
	if (plasmaBall) {
		plasmaBall->position = position;
		plasmaBall->startPos = position.y;
		plasmaBall->targetPos = targetY;
		if (isLeft) {
			plasmaBall->status_bits |= 1;
		}
	}
}

void ObjPlasmaBoss::action04_ChangePosition() {	
	switch (subroutine_id) {
	case 0x00:
		velocity.xf = (position.x - cameraBase.x > 160) ? 0x180 : -0x180;
		anim_id = 0;
		timer = 60;
		subroutine_id++;
		// fallthrough

	case 0x01:
		speedToPos();
		if (!--timer) {
			setAction((position.x - cameraBase.x > 160) ? enterLeft : enterRight);
		}
	}
}

void ObjPlasmaBoss::action05_EnterLeft() {
	switch (subroutine_id) {
	case 0x00:
		anim_id = 0;
		render_bits |= 1;
		status_bits |= 1;
		position.x = cameraBase.x + -0x20;
		position.y = cameraBase.y + 0x20;
		velocity.xf = 0xC0;
		subroutine_id++;
		//fallthrough
	case 0x01:
		{
			const auto targetX = cameraBase.x + 0x20;
			speedToPos();
			if (position.x >= targetX) {
				position.x = targetX;
				velocity.xf = 0;
				setNextActionFromScript();
			}
		}
	}
}

void ObjPlasmaBoss::setAction(Action action) {
	routine_id = action;
	subroutine_id = 0;
}

void execute_ObjPlasmaBoss(ObjPlasmaBoss & obj) {
	obj.execute();
}
