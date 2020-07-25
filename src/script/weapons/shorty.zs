// Shorty
// It's a short shotgun!
//
Class ShortyMag : Ammo {
	default {
		+Inventory.UNDROPPABLE
		+Inventory.IGNORESKILL
		Inventory.MaxAmount 3;
	}
}

Class ShortyPellet : BaseBullet {
	default {
		Scale 0.15;
		DamageFunction (5 + Random(0,10));
	}
}

Class Shorty : DNDWeapon {
	int magSize, numPellets;
	
	property magSize : magSize;
	property numPellets : numPellets;
	
	default {
		Weapon.slotnumber 3;
		Weapon.selectionorder 1000;
		Obituary "%o make ded from shootybang %k";
		Inventory.pickupmessage "Picked up a Berkut Super Shorty!";
		Weapon.kickback 	1000;
		Weapon.AmmoType1    "ShortyMag";
		Weapon.AmmoType2    "Shell";
		Weapon.AmmoUse1     0;
		Weapon.AmmoUse2     0;
		Weapon.AmmoGive1	3;   
		Weapon.AmmoGive2    60;
		Shorty.magSize		3;
		Shorty.numPellets	24;
	}
	
	action State A_ShortyAttack() {
		DNDWeapon weap = DNDWeapon(invoker);
		
		if (weap.Ammo1.Amount < 1) {
			return ResolveState("Reload");
		}		
		A_GunFlash();
		A_PlaySound("weapons/ShortyFire", CHAN_WEAPON);
		for (int pelletCount = 0; pelletCount < invoker.numPellets; pelletCount++) {
			A_FireProjectile("ShortyPellet", angle: FRandom(-4,4), flags: FPF_NOAUTOAIM, pitch: FRandom(-3,3));
		}
		A_TakeInventory(invoker.AmmoType1, 1);
		A_QuakeEx(3,3,3,4,0,30,"",QF_RELATIVE|QF_SCALEDOWN);
		return ResolveState(Null);	
	}
	
	// Sprite Index
	// A : Idle
	// B-I : Pump
	// JKLM : Reload End
	// N-U : Reload Loop
	// VWXY : Reload Start
	// SHOFA/B/C : Fire
	//
	States {
		Spawn:
			SHOP A -1;
			Stop;
		Ready:
			SHOR A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Select:
			SHOR A 1 A_Raise();
			Loop;
		Deselect:
			SHOR A 1 A_Lower();
			Loop;
		Fire:
			TNT1 A 9 A_ShortyAttack();
			SHOR A 6;
			TNT1 A 0 A_PlaySound("weapons/ShortyPumpDown", CHAN_BODY);
			SHOR B 2 A_WeaponOffset(6, 42, WOF_INTERPOLATE);
			SHOR C 2 A_WeaponOffset(5, 40, WOF_INTERPOLATE);
			SHOR D 2 A_WeaponOffset(0, 40, WOF_INTERPOLATE);
			SHOR E 2 A_WeaponOffset(0, 48, WOF_INTERPOLATE);
			SHOR F 2 A_WeaponOffset(0, 44, WOF_INTERPOLATE);
			TNT1 A 0 A_PlaySound("weapons/ShortyPumpUp", CHAN_BODY);
			SHOR G 2 A_WeaponOffset(0, 40, WOF_INTERPOLATE);
			SHOR HI 2;
			Goto Ready;
		Reload:
			SHOR A 1 {
				if (invoker.Ammo2.Amount < 1) {
					return ResolveState("NoAmmo");
				}
				return ResolveState(Null);	
			}
			SHOR VWXY 2;
			//SHOR E 2 A_PlaySound("weapons/SHORlerMagOut");
			SHOR NOPQRSTU 2;
			//SHOR B 4 A_WeaponOffset(6, 38, WOF_INTERPOLATE);	
			//SHOR B 6 A_WeaponOffset(0, 32, WOF_INTERPOLATE);
			//SHOR B 2 A_PlaySound("weapons/SHORlerMagIn");
			TNT1 A 0 A_PlaySound("weapons/ShortyShellIn");
			TNT1 A 0 {
				while ((invoker.Ammo1.Amount < invoker.magSize) && (invoker.Ammo2.Amount > 0)) {
					A_TakeInventory(invoker.AmmoType2, 1);
					A_GiveInventory(invoker.AmmoType1, 1);
				}
			}
			SHOR JKLM 2;
			Goto Ready;
		Flash:
			SHOF ABC 3 BRIGHT A_Light2();
			Goto LightDone;
		NoAmmo:
			SHOR A 25 A_PlaySound("misc/dry");
			Goto Ready;
	}
}
