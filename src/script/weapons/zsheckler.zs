// ZSHeckler
Class HecklerMag : Ammo {
	default {
		+Inventory.UNDROPPABLE
		+Inventory.IGNORESKILL
		Inventory.MaxAmount 24;
	}
}

Class ZSHeckler : DNDWeapon {
	int burstCount;	
	
	default {
		Weapon.slotnumber 2;
		Weapon.selectionorder 2000;
		Obituary "%o eat bullet from %k's Heckler.";
		Inventory.pickupmessage "You got the Heckler sub-machinegun!";
		Weapon.kickback 	1000;
		Weapon.AmmoType1    "HecklerMag";
		Weapon.AmmoType2    "Clip";
		Weapon.AmmoUse1     0;
		Weapon.AmmoUse2     0;
		Weapon.AmmoGive1	24;   
		Weapon.AmmoGive2    75;
		//AttackSound "weapons/HecklerFire"; //CS1.6 UMP45 Sound
		+weapon.Ammo_Optional
		//+weapon.Ammo_CheckBoth
	}
	
	action bool A_HecklerAttack() {
		DNDWeapon weap = DNDWeapon(invoker);
		if (!weap) {
			return false;
		}
		if ((weap.Ammo1.Amount <= 0) && (weap.Ammo2.Amount <= 0)) {
			A_PlaySound("misc/dry");
			return false;
		}
		A_GunFlash();
		A_PlaySound("weapons/HecklerFire", CHAN_WEAPON);
		A_FireProjectile("BaseBullet", useammo: true, spawnofs_xy: 3.8);
		A_TakeInventory("HecklerMag", 1);
		A_QuakeEx(3,3,3,4,0,30,"",QF_RELATIVE|QF_SCALEDOWN);
		return true;	
	}
	
	States {
		Spawn:
			HECP A -1;
			Stop;
		Ready:
			HECK A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Select:
			HECK A 1 A_Raise();
			Loop;
		Deselect:
			HECK A 1 A_Lower();
			Loop;
		Fire:
			TNT1 A 0 {
				if (CountInv("HecklerMag") < 1) {
					return ResolveState("Reload");
				}
				return ResolveState(Null);
			}
			HECK A 2 A_HecklerAttack();
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
			TNT1 A 0 {
				if (CountInv("HecklerMag") < 1) {
					return ResolveState("Reload");
				}
				return ResolveState(Null);
			}
			HECK A 2 A_HecklerAttack();
			HECK A 1 A_WeaponOffset(6, 42, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(5, 40, WOF_INTERPOLATE);
			HECK A 1 {
				if (CountInv("HecklerMag") < 1) {
					return ResolveState("Reload");
				}
				return ResolveState(Null);
			}
			//
			HECK A 2 A_HecklerAttack();
			HECK A 1 A_WeaponOffset(6, 42, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(5, 40, WOF_INTERPOLATE);
			TNT1 A 0 {
				if (CountInv("HecklerMag") < 1) {
					return ResolveState("Reload");
				}
				return ResolveState(Null);
			}
			//
			HECK A 2 A_HecklerAttack();
			HECK A 1 A_WeaponOffset(0, 40, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(0, 48, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(0, 44, WOF_INTERPOLATE);
			HECK A 2 A_WeaponOffset(0, 40, WOF_INTERPOLATE);
			HECK A 2 A_WeaponOffset(0, 37, WOF_INTERPOLATE);
			HECK A 3 A_WeaponOffset(0, 35, WOF_INTERPOLATE);
			TNT1 A 0 A_Refire("Burst");
			Goto Ready;
		Burst:
			TNT1 A 0 {
				if (CountInv("HecklerMag") < 1) {
					return ResolveState("Reload");
				}
				return ResolveState(Null);
			}
			HECK A 2 A_HecklerAttack();
			HECK A 1 A_WeaponOffset(6, 42, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(5, 40, WOF_INTERPOLATE);
			TNT1 A 0 {
				if (CountInv("HecklerMag") < 1) {
					return ResolveState("Reload");
				}
				return ResolveState(Null);
			}
			HECK A 2 A_HecklerAttack();
			HECK A 1 A_WeaponOffset(6, 42, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(5, 40, WOF_INTERPOLATE);
			TNT1 A 0 {
				if (CountInv("HecklerMag") < 1) {
					return ResolveState("Reload");
				}
				return ResolveState(Null);
			}
			//
			HECK A 2 A_HecklerAttack();
			HECK A 1 A_WeaponOffset(6, 42, WOF_INTERPOLATE);
			HECK A 1 A_WeaponOffset(5, 40, WOF_INTERPOLATE);
			TNT1 A 0 {
				if (CountInv("HecklerMag") < 1) {
					return ResolveState("Reload");
				}
				return ResolveState(Null);
			}
			//
			HECK A 2 A_HecklerAttack();
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
				if (CountInv("Clip") < 1) {
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
				while ((CountInv("HecklerMag") < 24) && (CountInv("Clip") > 0)) {
					A_TakeInventory("Clip", 1);
					A_GiveInventory("HecklerMag", 1);
				}
			}
			HECK CDEFHI 2;
			Goto Ready;
		Flash:
			HECF A 2 BRIGHT A_Light2();
			//HECK C 1 A_Light0
			Goto LightDone;
		NoAmmo:
			HECK A 25 A_PlaySound("misc/dry");
			Goto Ready;
	}
}
