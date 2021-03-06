Class DNDebugPlayer : DoomPlayer {
	PlayerInfo player;
	int meleeCooldown;
	
	property meleeCooldown : meleeCooldown;
	
	default {
		/* debug stuff */
		//Player.StartItem "Pistol";
		//Player.StartItem "Heckler";
		Player.StartItem "TestGun";
		Player.StartItem "Shorty";
		//Player.StartItem "Fist";
		Player.StartItem "Clip", 999;
		Player.StartItem "Shell", 999;
		Player.DisplayName "Debug Guy";
		DNDebugPlayer.meleeCooldown 0;
		
		//Player.ViewBob 0.5;
	}

	
	action bool PressingFire(){return player.cmd.buttons & BT_ATTACK;}
    action bool PressingAltfire(){return player.cmd.buttons & BT_ALTATTACK;}
    action bool PressingReload(){return player.cmd.buttons & BT_RELOAD;}
    action bool PressingZoom(){return player.cmd.buttons & BT_ZOOM;}
    action bool PressingUser1(){return player.cmd.buttons & BT_USER1;}
    action bool PressingUser2(){return player.cmd.buttons & BT_USER2;}
    action bool PressingUser3(){return player.cmd.buttons & BT_USER3;}
    action bool PressingUser4(){return player.cmd.buttons & BT_USER4;}
	
	override void PostBeginPlay() {
		player = players[consoleplayer];
		super.PostBeginPlay();
		meleeCooldown = 0;
	}	
	
	
	override void Tick() {
		/*
		if (player && testGasShader) {
			Shader.SetUniform1f(player, "TearGas", "mf_time", (level.totaltime / 35.0));
			Shader.SetEnabled(player, "TearGas", true);
		}
		*/
		if (player && PressingUser1()) {
			if (meleeCooldown < 1) {
				A_Overlay(777, "MeleeAttack");
				meleeCooldown = 45;
			}
		}
		if (meleeCooldown > 0) {
			meleeCooldown--;
		}
		super.Tick();
	}
	
	States {	
		MeleeAttack:
			//TNT1 A 1 A_MoveWeap(true); 
			PUNG A 4 A_OverlayOffset(777, 24, 220, WOF_ADD);
			PUNG B 3 A_OverlayOffset(777, -24, -220, WOF_ADD);
			PUNG C 2 {
				if (A_GenMelee()) {
					Console.printf("THUMP CRUNCH");
				}
				else {
					Console.printf("WHOOOPS");
				}
			}
			PUNG D 4;
			PUNG C 5;
			PUNG B 6;
			PUNG B 4 A_OverlayOffset(777, 0, 120, WOF_ADD);
			//TNT1 A 1 A_MoveWeap(false);
			Stop;
	}
	
	// modified code from weaponfist.zs / fighterfist.zs 
	// returns true if target hit, otherwise false
	//
	action bool A_GenMelee() {
		Console.printf("GENERIC MELEE ATTACK!");
		FTranslatedLineTarget t;
		
		int damage = random(10, 20);
		if (FindInventory("PowerStrength")) {
			damage *= 10;
		}

		double ang = angle + Random2[Punch]() * (5.625 / 256);
		double pitch = AimLineAttack (ang, DEFMELEERANGE, null, 0., ALF_CHECK3D);
		LineAttack (ang, DEFMELEERANGE, pitch, damage, 'Melee', "BulletPuff", LAF_ISMELEEATTACK, t);
		// turn to face target
		if (t.linetarget) {
			angle = t.angleFromSource;
			return true;
		}
		else { return false; }
	}
	
	/*
	action void A_MoveWeap(bool doHide)
    {        
        if (!player) {
			return;
		}
 
		let weap = DNDWeapon(player.readyWeapon);
        let weapSprite = player.GetPsprite(PSP_WEAPON);
		
        if (doHide) {
			weapSprite.y += 60;
		}
		else {
			weapSprite.y -= 60;
		}
		return;
    }
	action bool A_HideWeap() {
		StateLabel st = "MeleeHide";
		DNDWeapon weap = DNDWeapon(player.readyWeapon);
		if (!weap) {
			return false;		
		}
		weap.SetState(ResolveState(st));		
		return true;
	}
	
	action bool A_ReturnWeap() {
		StateLabel st = "MeleeUnhide";
		DNDWeapon weap = DNDWeapon(player.readyWeapon);
		if (!weap) {
			return false;		
		}
		weap.SetState(ResolveState(st));
		return true;
	}
	*/
		
}
//eof