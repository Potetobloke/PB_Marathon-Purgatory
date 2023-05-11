version "4.8.2"

#include "zscript/zwl/zwl.zs"
#include "zscript/status_bar.zs"

#include "zscript/gutamatics/include.zs"

#include "zscript/Replacer.zsc"

#include "zscript/Items/ItemBase.zsc"
#include "zscript/Items/Powerup.zsc"
#include "zscript/Weapons/Base.zsc"

class MarSecurityOfficer : DoomPlayer
{
    Default
    {
		Health 100;
		Radius 16;
		Height 56;
		Mass 100;
		Gravity 0.35;
		Friction 0.925;
		Player.JumpZ 6;
		Player.ForwardMove 10.75;
		Player.SideMove 10.75;
		
		//+DONTBLAST
		
		Player.DisplayName "Security Officer";
		Player.StartItem "MarPistol_Weapon";
        Player.StartItem "MarPistol_Ammo", 48;
		Player.StartItem "MarFist_Weapon";
		Player.ViewBob 7.5;

		Player.WeaponSlot 1, "MarFist_Weapon";
        Player.WeaponSlot 2, "MarPistol_Weapon";
        Player.WeaponSlot 3, "MarShotgun_Weapon";
		Player.WeaponSlot 4, "MarSubmachineGun_Weapon","MarAssaultRifle_Weapon";
		Player.WeaponSlot 5, "MarRocketLauncher_Weapon";
		Player.WeaponSlot 6, "MarFlamethrower_Weapon","MarFusionPistol_Weapon";
		Player.WeaponSlot 7, "MarWaveMotionCannon_Weapon";
		Player.WeaponSlot 0, "MarAlienGun_Weapon","MarAlienGun2_Weapon";
    }
	
	/*override void tick()
	{
		//Super.Tick();
		A_GiveInventory("MarFist_Weapon",1);
		Super.Tick();
	}*/
		
	override Vector2 BobWeapon(double ticfrac)
		{
			Vector2 p1, p2, r;
			Vector2 result;

			let player = self.player;
			if (!player) return (0, 0);
			let weapon = player.ReadyWeapon;

			if (weapon == null || weapon.bDontBob)
			{
				return (0, 0);
			}

			// [XA] Get the current weapon's bob properties.
			int bobstyle = weapon.BobStyle;
			double BobSpeed = (weapon.BobSpeed * 128);
			double Rangex = weapon.BobRangeX;
			double Rangey = weapon.BobRangeY;

			for (int i = 0; i < 2; i++)
			{
				// Bob the weapon based on movement speed. ([SP] And user's bob speed setting)
				double angle = (BobSpeed * player.GetWBobSpeed() * 35 /	TICRATE*(Level.maptime - 1 + i)) * (360. / 8192.);

				// [RH] Smooth transitions between bobbing and not-bobbing frames.
				// This also fixes the bug where you can "stick" a weapon off-center by
				// shooting it when it's at the peak of its swing.
				if (curbob != player.bob)
				{
					if (abs(player.bob - curbob) <= 1)
					{
						curbob = player.bob;
					}
					else
					{
						double zoom = MAX(1., abs(curbob - player.bob) / 40);
						if (curbob > player.bob)
						{
							curbob -= zoom;
						}
						else
						{
							curbob += zoom;
						}
					}
				}

				// The weapon bobbing intensity while firing can be adjusted by the player.
				double BobIntensity = (player.WeaponState & WF_WEAPONBOBBING) ? 1. : 1.0;

				if (curbob != 0)
				{
					double bobVal = player.bob;
					if (i == 0)
					{
						bobVal = prevBob;
					}
					//[SP] Added in decorate player.viewbob checks
					double bobx = (bobVal * BobIntensity * Rangex * ViewBob);
					double boby = (bobVal * BobIntensity * Rangey * ViewBob);
					//bobbing
						r.Y = 0.5f * (boby * (1. + (cos(angle * 2))));
				}
				else
				{
					r = (0, 0);
				}
				if (i == 0) p1 = r; else p2 = r;
			}
			return p1 * (1. - ticfrac) + p2 * ticfrac;
		}
		
		States
	{
		See: //to ensure the player NEVER loses the fists
			PLAY ABCD 4 A_GiveInventory("MarFist_Weapon",1);
			Loop;
	}
}

class MarathonDummy:Actor{
	bool ticked;
	default{
		+noclip +nointeraction +noblockmap -solid
		height 1;radius 1;
	}
}