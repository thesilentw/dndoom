// TestGun
// For testing all kinds of stupid shit
//
Class TestMag : Ammo {
	default {
		+Inventory.UNDROPPABLE
		+Inventory.IGNORESKILL
		Inventory.MaxAmount 999;
	}
}

Class TestGun : DNDWeapon {
	int burstCount, burstMax, magSize, reserveSize;
	
	property burstCount : burstCount;
	property burstMax : burstMax;
	property magSize : magSize;
	property reserveSize : reserveSize;
	
	default {
		Weapon.slotnumber 1;
		Weapon.selectionorder 1000;
		Obituary "%o make ded from shootybang %k";
		Inventory.pickupmessage "What IS this thing? It seems to be a conglomeration of dumb experiments and bullshit.";
		//Weapon.kickback 	1000;
		Weapon.AmmoType1    "TestMag";
		Weapon.AmmoType2    "Clip";
		Weapon.AmmoUse1     0;
		Weapon.AmmoUse2     0;
		Weapon.AmmoGive1	20;   
		Weapon.AmmoGive2    60;
		TestGun.burstCount 	0;
		TestGun.burstMax 	4;
		TestGun.magSize		20;
		TestGun.reserveSize	60;
	}
	
	action State A_TestAttack() {
		DNDWeapon weap = DNDWeapon(invoker);
		
		if (weap.Ammo1.Amount < 1) {
			return ResolveState("Reload");
		}		
		A_GunFlash();
		A_PlaySound("weapons/HecklerFire", CHAN_WEAPON);
		A_FireProjectile("BaseBullet", useammo: true, spawnofs_xy: 3.8);
		A_TakeInventory("TestMag", 1);
		A_QuakeEx(3,3,3,4,0,30,"",QF_RELATIVE|QF_SCALEDOWN);
		//invoker.burstCount++;
		return ResolveState(Null);	
	}
	
	States {
		Spawn:
			HECP A -1;
			Stop;
		Ready:
			HECK A 1 A_WeaponReady(WRF_ALLOWRELOAD | WRF_NOBOB);
			Loop;
		Select:
			HECK A 1 A_Raise();
			Loop;
		Deselect:
			HECK A 1 A_Lower();
			Loop;
		Fire:
			HECK A 2 A_TestAttack();
			HECK A 1 A_WeaponOffset(6, 42, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(5, 40, WOF_INTERPOLATE);
			TNT1 A 0 A_ReFire("InitialBurst");
			HECK A 1 A_WeaponOffset(0, 40, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(0, 48, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(0, 44, WOF_INTERPOLATE);
			HECK A 2 A_WeaponOffset(0, 40, WOF_INTERPOLATE);
			TNT1 A 0 A_Refire("Fire");
			HECK A 2 A_WeaponOffset(0, 37, WOF_INTERPOLATE);
			TNT1 A 0 A_Refire("Fire");
			HECK A 3 A_WeaponOffset(0, 35, WOF_INTERPOLATE);
			TNT1 A 0 A_Refire("Fire");
			Goto Ready;
		InitialBurst:
			HECK A 2 A_TestAttack();
			HECK A 1 A_WeaponOffset(6, 42, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(5, 40, WOF_INTERPOLATE);
			HECK A 2 A_TestAttack();
			HECK A 1 A_WeaponOffset(6, 42, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(5, 40, WOF_INTERPOLATE);
			HECK A 2 A_TestAttack();
			HECK A 1 A_WeaponOffset(0, 40, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(0, 48, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(0, 44, WOF_INTERPOLATE);
			HECK A 2 A_WeaponOffset(0, 40, WOF_INTERPOLATE);
			HECK A 2 A_WeaponOffset(0, 37, WOF_INTERPOLATE);
			HECK A 3 A_WeaponOffset(0, 35, WOF_INTERPOLATE);
			TNT1 A 0 A_Refire("Burst");
			Goto Ready;
		Burst:
			HECK A 2 A_TestAttack();
			HECK A 1 A_WeaponOffset(6, 42, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(5, 40, WOF_INTERPOLATE);
			HECK A 2 A_TestAttack();
			HECK A 1 A_WeaponOffset(6, 42, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(5, 40, WOF_INTERPOLATE);
			HECK A 2 A_TestAttack();
			HECK A 1 A_WeaponOffset(6, 42, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(5, 40, WOF_INTERPOLATE);
			HECK A 2 A_TestAttack();
			HECK A 1 A_WeaponOffset(0, 40, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(0, 48, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(0, 44, WOF_INTERPOLATE);
			HECK A 2 A_WeaponOffset(0, 40, WOF_INTERPOLATE);
			HECK A 2 A_WeaponOffset(0, 37, WOF_INTERPOLATE);
			HECK A 3 A_WeaponOffset(0, 35, WOF_INTERPOLATE);
			TNT1 A 0 A_Refire("Burst");
			Goto Ready;
		Reload:
			HECK A 1 {
				if (invoker.Ammo2.Amount < 1) {
					return ResolveState("NoAmmo");
				}
				return ResolveState(Null);	
			}
			HECK IHGF 2;
			HECK E 2 A_PlaySound("weapons/HecklerMagOut");
			HECK DCB 2;
			HECK B 4 A_WeaponOffset(6, 38, WOF_INTERPOLATE);	
			HECK B 6 A_WeaponOffset(0, 32, WOF_INTERPOLATE);
			HECK B 2 A_PlaySound("weapons/HecklerMagIn");
			TNT1 A 0 {
				while ((invoker.Ammo1.Amount < invoker.magSize) && (invoker.Ammo2.Amount > 0)) {
					A_TakeInventory(invoker.AmmoType2, 1);
					A_GiveInventory(invoker.AmmoType1, 1);
				}
			}
			HECK CDEFHI 2;
			Goto Ready;
		Flash:
			HECF A 2 BRIGHT A_Light2();
			Goto LightDone;
		NoAmmo:
			HECK A 25 A_PlaySound("misc/dry");
			Goto Ready;
	}
}
