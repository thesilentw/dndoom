Class BaseBullet : FastProjectile {	
	Default {
		Radius 2;
		Height 4;
		Scale 0.6;
		Speed 300;
		DamageFunction 15;
		ProjectileKickback 200;
		MissileType "BulletTrail";
		MissileHeight 8;
		Projectile;
		+RANDOMIZE
		+BLOODSPLATTER
		RenderStyle "Add";
		//DeathSound "Punch/Wham";
		Alpha 1;
		Decal "BulletChip";
	}
  
	States {
		Spawn:
			PUFF A 1 Bright;
			Loop;
		Death:
			PUFF A 1 A_FadeOut(0.2);
			Stop;
	}
}

Class BulletTrail : Actor {	
	Default {
		Height 1;
		Radius 1;
		Scale 0.3;
		RenderStyle "Add";
		Alpha 0.4;
		+NOGRAVITY
	}
	
	States {
		Spawn:
			PUFF A 1 bright A_FadeOut(0.5);
			Loop;
	}
}