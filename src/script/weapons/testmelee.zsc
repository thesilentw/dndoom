// Test Melee thingy
//
// The idea is to make an item that polls for a keypress
// and when it gets it, swings a knife / boot / whateverthefuck
//
//
 
Class TestMelee : CustomInventory {

	default {
		+Inventory.UNDROPPABLE
		+Inventory.IGNORESKILL
		+INVENTORY.AUTOACTIVATE
		Inventory.MaxAmount 1;
	}
	
	override void PostBeginPlay() {
		super.PostBeginPlay();	
	}
	
	action bool PressingFire(){return player.cmd.buttons & BT_ATTACK;}
    action bool PressingAltfire(){return player.cmd.buttons & BT_ALTATTACK;}
    action bool PressingReload(){return player.cmd.buttons & BT_RELOAD;}
    action bool PressingZoom(){return player.cmd.buttons & BT_ZOOM;}
    action bool PressingUser1(){return player.cmd.buttons & BT_USER1;}
    action bool PressingUser2(){return player.cmd.buttons & BT_USER2;}
    action bool PressingUser3(){return player.cmd.buttons & BT_USER3;}
    action bool PressingUser4(){return player.cmd.buttons & BT_USER4;}
	/*
	override void Tick() {
		if ( PressingZoom() ) {
			A_Overlay(777, "Attack");
		}
		super.Tick();
	}
	*/
	
	States {
		Spawn:
			TLGL A -1;
			Stop;
		Pickup:
			TNT1 A 1;
			Stop;
		Use:
			TNT1 A 1 {
				if (player.cmd.buttons & BT_ZOOM) {
					A_Overlay(777, "Attack");
				}
			}
			Loop;
			
		Attack:
			PUNG A 4 A_OverlayOffset(777, 24, 42, WOF_ADD);
			PUNG B 3 A_OverlayOffset(777, -24, -42, WOF_ADD);
			PUNG C 2 A_CustomPunch(2 * random(1, 10), TRUE);
			PUNG D 4;
			PUNG C 5;
			PUNG B 6;
			PUNG B 4 A_OverlayOffset(777, 0, 42, WOF_ADD);
			PUNG A 4 A_OverlayOffset(777, 0, -42, WOF_ADD);
			Stop;
	}






}