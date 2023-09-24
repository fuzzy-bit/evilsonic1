
#include "S1Engine.hpp"
#include <cstdint>

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
	// Intro ---
	ObjPlasmaBoss::Action::enterRight,		// 0
	ObjPlasmaBoss::Action::attractBalls,	// 1

	// Warm-up --
	ObjPlasmaBoss::Action::verticalAttack,	// 2
	ObjPlasmaBoss::Action::verticalAttack,	// 3
	ObjPlasmaBoss::Action::verticalAttack,	// 4
	ObjPlasmaBoss::ActionScriptFlag::jumpIfHealthAbove, 10, 2,	// 5,6,7

	// Gettin' angry --
	ObjPlasmaBoss::Action::verticalWallAttack,	// 8
	ObjPlasmaBoss::Action::changePosition,		// 9
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalWallAttack,
	ObjPlasmaBoss::Action::changePosition,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::ActionScriptFlag::jumpIfHealthAbove, 8, 8,

	// Full pinch mode
	ObjPlasmaBoss::Action::verticalWallAttack,	// 8
	ObjPlasmaBoss::Action::changePosition,		// 9
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalWallAttack,
	ObjPlasmaBoss::Action::changePosition,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::Action::verticalAttack,
	ObjPlasmaBoss::ActionScriptFlag::jumpTo, 8,
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
		health = 14;
		playSound__cdecl(0x8C);
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

	case ObjPlasmaBoss::Action::verticalWallAttack:
		action06_VerticalWallAttack();
		goto display;

	case ObjPlasmaBoss::Action::defeated:
		action07_Defeated();
		goto displayOnly;

	display:
		// Using charging animation?
		if (anim_id == 1) {
			playChargingSound(routine_id == ObjPlasmaBoss::Action::attractBalls ? 0x3 : 0x7);
		}
		handleDamage();

	displayOnly:
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

			playSound__cdecl(0xAC);	// play boss damage sound

			// Are we defeated?
			if (status_bits & 0x80) {
				setAction(defeated);
				return;
			}

			flash_timer = 0x21;
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
			const auto targetX = cameraBase.x + 320-0x18;
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
		timer = !isInPinchMode() ? 60 : 30;
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
				auto plasmaBall = verticalAttack_MakeBall(ballY, isLeft);
				if (plasmaBall) {
					plasmaBall->timer = isInPinchMode() ? 8 : 30;
				}
			}
			// Generate balls below
			for (int16_t ballY = targetYPos + 0x18*2; ballY <= cameraBase.y + 0x40 + 4 * 0x20; ballY += 0x18) {
				auto plasmaBall = verticalAttack_MakeBall(ballY, isLeft);
				if (plasmaBall) {
					plasmaBall->timer = isInPinchMode() ? 8 : 30;
				}
			}
			timer = !isInPinchMode() ? 120 : 60;
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

inline ObjPlasmaBall * ObjPlasmaBoss::verticalAttack_MakeBall(int16_t targetY, bool isLeft) {
	auto plasmaBall = create_ObjPlasmaBall(this, ObjPlasmaBall::Subtype::verticalAttack);
	if (plasmaBall) {
		plasmaBall->position = position;
		plasmaBall->startPos = position.y;
		plasmaBall->targetPos = targetY;
		if (isLeft) {
			plasmaBall->status_bits |= 1;
		}
	}
	return plasmaBall;
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
			const auto targetX = cameraBase.x + 0x18;
			speedToPos();
			if (position.x >= targetX) {
				position.x = targetX;
				velocity.xf = 0;
				setNextActionFromScript();
			}
		}
	}
}

void ObjPlasmaBoss::action06_VerticalWallAttack() {
	switch (subroutine_id) {
	case 0x00:		// reach target position
		{
			const int16_t targetY = cameraBase.y + 0x20;
			velocity.yf = targetY > position.y ? 0x100 : -0x100;
			anim_id = 0;	// use normal animation
			timer = 60;
			subroutine_id++;
		}
		// fallthrough

	case 0x01:	// aim 'n' shoot!
		{
			const int16_t targetY = cameraBase.y + 0x20;

			// Move to target position
			if (position.y != targetY) {
				speedToPos();
			}
			// Stop moving and wait
			else if (timer) {
				timer--;
				velocity.yf = 0;
			}
			// Generate balls
			else {
				const bool isLeft = position.x - cameraBase.x < 160;

				anim_id = 1;	// use charging animation
				timer = !isLeft ? 30 + 8 * 30 + 60 : 30 + 8 * 60;

				for (int16_t ballIndex = 0; ballIndex < 7; ++ballIndex) {
					const int16_t ballY = position.y + 0x18 + ballIndex * 0x18;
					auto plasmaBall = verticalAttack_MakeBall(ballY, isLeft);
					if (plasmaBall) {
						plasmaBall->timer = 30 + ballIndex * (!isLeft ? 30 : 60);
					}
				}
				subroutine_id++;
			}
		}
		break;

	case 0x02:		// wait for da balls!
		if (!--timer) {
			setNextActionFromScript();
		}
		break;
	}
}

void ObjPlasmaBoss::action07_Defeated() {
	switch (subroutine_id) {
	case 0x00:
		velocity = { .xf = 0, .yf = 0 };
		timer = 180;
		anim_id = 0;		// use normal animation
		subroutine_id++;
		// fallthrough

	case 0x01:
		// Explosion special effects
		if ((v_framecount & 0x7) == 0) {
			LevelObject * explosion = static_cast<LevelObject*>(findFreeObj__cdecl());
			if (explosion) {
				const uint8_t angle = randomNumber__cdecl();
				const int16_t sin = calcSine__cdecl(angle);
				const int16_t cos = calcSine__cdecl(angle+0x40);

				explosion->id = 0x3F;
				explosion->position = position;
				explosion->velocity.xf = cos * 2;
				explosion->velocity.yf = sin * 2;
				// Debug::kwrite("xvel=\x89, yvel=\x89\xE0", explosion->velocity.xf, explosion->velocity.yf);
			}
		}
		else if (((v_framecount+4) & 0x7) == 0) {
			auto plasmaBall = create_ObjPlasmaBall(this, ObjPlasmaBall::particleMove);
			if (plasmaBall) {
				const uint8_t angle = randomNumber__cdecl();
				const int16_t sin = calcSine__cdecl(angle);
				const int16_t cos = calcSine__cdecl(angle+0x40);

				plasmaBall->position = position;
				plasmaBall->velocity.xf = cos * 4;			
				plasmaBall->velocity.yf = sin * 4;		
				Debug::kwrite("xvel=\x89, yvel=\x89\xE0", plasmaBall->velocity.xf, plasmaBall->velocity.yf);	
			}
		}

		// Wait timer
		if (timer) {
			timer--;
		}
		// Start moving up
		else {
			if (velocity.yf > -0x180) {
				velocity.yf -= 0x8;
			}
			speedToPos();
			if (position.y <= cameraBase.y - 0x30) {
				velocity.yf = 0;
				LevelObject * eggmanShip = static_cast<LevelObject*>(findFreeObj__cdecl());
				if (eggmanShip) {
					eggmanShip->id = 0x85;
				}
				subroutine_id++;
			}
		}
		break;

	case 0x02:	// We're done here ...
		// Too tired to handle deletion
		position.x = 0;
		position.y = 0;
		break;

	}
}

inline void ObjPlasmaBoss::playChargingSound(uint16_t periodMask) {
	if ((v_framecount & periodMask) == 0) {
		playSound__cdecl(0xB1);
	}
}

inline bool ObjPlasmaBoss::isInPinchMode() {
	return health <= 3;
}

void ObjPlasmaBoss::setAction(Action action) {
	routine_id = action;
	subroutine_id = 0;
}

void execute_ObjPlasmaBoss(ObjPlasmaBoss & obj) {
	obj.execute();
}
