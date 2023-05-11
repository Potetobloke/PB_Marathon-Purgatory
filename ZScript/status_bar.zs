class PB_MarsBar : BaseStatusBar
{
	HUDFont mHUDFont;
	HUDFont mIndexFont;
	HUDFont mAmountFont;
	MarSecurityOfficer mso;
	hudfont msmallfont;
	hudfont mnewsmallfont;
	InventoryBarState diparms;
	
	override void Init(){
		Super.Init();
		SetSize(32, 320, 200);

		Font fnt = "HUDFONT_DOOM";
		msmallfont=HUDFont.Create(SmallFont);
		mnewsmallfont=HUDFont.Create(NewSmallFont);
		mHUDFont = HUDFont.Create(fnt,fnt.GetCharWidth("0"),true,1,1);
		fnt = "INDEXFONT_DOOM";
		mIndexFont = HUDFont.Create(fnt,fnt.GetCharWidth("0"),true);
		diparms = InventoryBarState.Create();
	}
	
	override void Draw (int state, double TicFrac)
	{
		Super.Draw (state, TicFrac);

		if (state == HUD_StatusBar)
		{
			BeginHUD(true);
			DrawMainBar (TicFrac);
		}
		else if (state == HUD_Fullscreen)
		{
			BeginHUD();
			DrawFullScreenStuff ();
		}
	}
	
	protected void DrawMainBar (double TicFrac)
	{
		drawimage("UI_StBar",(0,0),DI_SCREEN_CENTER_BOTTOM,scale:(0.5,0.5));
	}
	
	protected void DrawFullScreenStuff ()
	{
			//drawimage("UI_44wep",(175,-20),DI_SCREEN_CENTER_BOTTOM);
			Inventory ammotype1, ammotype2;
			[ammotype1, ammotype2] = GetCurrentAmmo();
			//let ammoType2 = GetCurrentAmmo();
            let weapon = MarathonWeapon(cplayer.readyWeapon);
			
			/*if (ammoType1 && weapon && weapon.magazineSize > 0 
			&& weapon.magazineSize2 > 0 && weapon.secondarymode > 0 && weapon.akimboweapon > 0)
            {
				//mags
				DrawString(mHUDFont, StringStruct.Format("%d %d", weapon.ammoCount2, weapon.ammoCount), 
				(-30, -60),DI_TEXT_ALIGN_RIGHT);
				//spare
				DrawString(mHUDFont, StringStruct.Format("%d ", ((ammoType1.amount)/(weapon.magazinesize))), (-90, -60),
                           DI_TEXT_ALIGN_RIGHT);
			}
            else if (ammoType1 && weapon && weapon.magazineSize > 0 
			&& weapon.magazineSize2 > 0 && weapon.secondarymode > 0)
            {
				//mags
				DrawString(mHUDFont, StringStruct.Format("%d %d", weapon.ammoCount, weapon.ammoCount2), 
				(-30, -60),DI_TEXT_ALIGN_RIGHT);
				
				//spare
				DrawString(mHUDFont, StringStruct.Format("%d ", ((ammoType1.amount)/(weapon.magazinesize))), (-90, -60),
							DI_TEXT_ALIGN_RIGHT);
						   
				DrawString(mHUDFont, StringStruct.Format("%d ", ((ammoType2.amount)/(weapon.magazinesize2))), (-90, -40),
							DI_TEXT_ALIGN_RIGHT);
            }
			else if (ammoType1 && weapon && weapon.magazineSize > 0)
            {
            //    DrawString(mHUDFont, StringStruct.Format("%d %d", weapon.ammoCount, ammoType1.amount), (-30, -20),
            //               DI_TEXT_ALIGN_RIGHT);
				DrawString(mHUDFont, StringStruct.Format("%d", weapon.ammoCount), 
				(-30, -60),DI_TEXT_ALIGN_RIGHT);
			//spare
				DrawString(mHUDFont, StringStruct.Format("%d ", ((ammoType1.amount)/(weapon.magazinesize))), (-90, -60),
                           DI_TEXT_ALIGN_RIGHT);
            }
			*/
		
		//------------------//
		//	yuge hud funcs	//
		//------------------//
		
		//health
		{
			//drawimage("UI_Back",(52,35),DI_SCREEN_LEFT_BOTTOM);
			drawimage("UI_Bord",(-65,96),DI_SCREEN_LEFT_BOTTOM);
			
																//84.5
			drawbar("UI_Hbar1","UI_Hbar0",cplayer.health,100,(90.5,-35),0,SHADER_HORZ,DI_SCREEN_LEFT_BOTTOM);
			drawbar("UI_Hbar2","UI_Hbar4",cplayer.health-100,100,(90.5,-35),0,SHADER_HORZ,DI_SCREEN_LEFT_BOTTOM);
			drawbar("UI_Hbar3","UI_Hbar4",cplayer.health-200,100,(90.5,-35),0,SHADER_HORZ,DI_SCREEN_LEFT_BOTTOM);
			
			drawbar("UI_Abar0","UI_Hbar0",GetArmorAmount(),100,(90.5,-24),0,SHADER_HORZ,DI_SCREEN_LEFT_BOTTOM);
			drawbar("UI_Abar1","UI_Hbar4",(GetArmorAmount())-100,100,(90.5,-24),0,SHADER_HORZ,DI_SCREEN_LEFT_BOTTOM);
			//drawbar("UI_O2bar","UI_Hbar0",cplayer.air,cplayer.AirCapacity,(62.5,-13),0,SHADER_HORZ,DI_SCREEN_LEFT_BOTTOM);
		}
		
		//Keys
		{
			bool locks[6];
			String image;
			for(int i = 0; i < 6; i++) locks[i] = CPlayer.mo.CheckKeys(i + 1, false, true);
		
			drawimage((locks[2])?"UI_CardY":"UI_CardE",(50.5,-13.5),DI_SCREEN_LEFT_BOTTOM,scale:(0.75,0.75));
			drawimage((locks[1])?"UI_CardB":"UI_CardE",(60.5,-13.5),DI_SCREEN_LEFT_BOTTOM,scale:(0.75,0.75));
			drawimage((locks[0])?"UI_CardR":"UI_CardE",(70.5,-13.5),DI_SCREEN_LEFT_BOTTOM,scale:(0.75,0.75));
			
			drawimage((locks[5])?"UI_SkulY":"UI_SkulE",(50.5,-2),DI_SCREEN_LEFT_BOTTOM,scale:(0.75,0.75));
			drawimage((locks[4])?"UI_SkulB":"UI_SkulE",(60.5,-2),DI_SCREEN_LEFT_BOTTOM,scale:(0.75,0.75));
			drawimage((locks[3])?"UI_SkulR":"UI_SkulE",(70.5,-2),DI_SCREEN_LEFT_BOTTOM,scale:(0.75,0.75));

		}
		//Motion Sensor
		{
			drawimage("MS_Back",(22,-7),DI_SCREEN_LEFT_BOTTOM,scale:(0.3,0.3));
			drawimage("MS_WIP",(22,-7),DI_SCREEN_LEFT_BOTTOM,scale:(0.3,0.3));
		}
		//guns
		{
			//drawimage("UI_Back",(-60,35),DI_SCREEN_RIGHT_BOTTOM);
			drawimage("UI_Bord",(60,96),DI_SCREEN_RIGHT_BOTTOM);
			
			//.44 Magnum Mega Class
			if (weapon is "MarPistol_Weapon")
			{//StringStruct.Format("%d ", ((ammoType1.amount)/(weapon.magazinesize)))
				drawimage("UI_44wep",(-30.5,-11.5),DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
				drawimage((weapon.secondarymode>0)?"UI_44aki":"UI_44ext",(-90.5,-11.5),DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
				
				DrawString(mnewsmallfont,"\c[MarGreen].44 Magnum Mega Class", (-65, -10),
                DI_TEXT_ALIGN_CENTER|DI_SCREEN_RIGHT_BOTTOM,scale:(0.375,0.375));
				
				//8 rounds per row
				drawbar("UI_44am","UI_44sp",weapon.ammoCount,8,(-39,-11),0,SHADER_REVERSE,DI_SCREEN_RIGHT_BOTTOM);
				if(weapon.secondarymode > 0)
					{drawbar("UI_44am","UI_44sp",weapon.ammoCount2,8,(-82,-11),0,SHADER_HORZ,DI_SCREEN_RIGHT_BOTTOM);}
					
				//spare ammo counter
				DrawString(mnewsmallfont, StringStruct.Format("\c[MarGreen]x%d ", ((ammoType1.amount)/(weapon.magazinesize))), (-135, -28.5),
                           DI_TEXT_ALIGN_LEFT|DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
			
			}
			
			//MA-75B Assault Rifle
			if (weapon is "MarAssaultRifle_Weapon")
			{//StringStruct.Format("%d ", ((ammoType1.amount)/(weapon.magazinesize)))
				drawimage("UI_ARwep",(-50.5,-11.5),DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
				
				DrawString(mnewsmallfont,"\c[MarGreen]MA-75B Assault Rifle", (-65, -10),
                DI_TEXT_ALIGN_CENTER|DI_SCREEN_RIGHT_BOTTOM,scale:(0.375,0.375));
				
				//13 rounds per row
				drawbar("UI_ARam","UI_ARsp",weapon.ammoCount,13,(-115,-38),0,SHADER_HORZ,DI_SCREEN_RIGHT_BOTTOM);
				drawbar("UI_ARam","UI_ARsp",weapon.ammoCount-13,13,(-115,-31),0,SHADER_HORZ,DI_SCREEN_RIGHT_BOTTOM);
				drawbar("UI_ARam","UI_ARsp",weapon.ammoCount-26,13,(-115,-24),0,SHADER_HORZ,DI_SCREEN_RIGHT_BOTTOM);
				drawbar("UI_ARam","UI_ARsp",weapon.ammoCount-39,13,(-115,-17),0,SHADER_HORZ,DI_SCREEN_RIGHT_BOTTOM);
				drawbar("UI_GLam","UI_GLsp",weapon.ammoCount2,7,(-115,-8),0,SHADER_HORZ,DI_SCREEN_RIGHT_BOTTOM);
			
				//spare ammo counter
				DrawString(mnewsmallfont, StringStruct.Format("\c[MarGreen]x%d ", ((ammoType1.amount)/(weapon.magazinesize))), (-95, -28.5),
                           DI_TEXT_ALIGN_LEFT|DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
				DrawString(mnewsmallfont, StringStruct.Format("\c[MarGreen]x%d ", ((ammoType2.amount)/(weapon.magazinesize2))), (-95, -19.5),
                           DI_TEXT_ALIGN_LEFT|DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
			
			}
			
			//KKV-7 10mm SMG Flechette
			if (weapon is "MarSubmachineGun_Weapon")
			{//StringStruct.Format("%d ", ((ammoType1.amount)/(weapon.magazinesize)))
				drawimage("UI_SMGwp",(-50.5,-11.5),DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
				
				DrawString(mnewsmallfont,"\c[MarGreen]KKV-7 10mm SMG Flechette", (-75, -10),
                DI_TEXT_ALIGN_CENTER|DI_SCREEN_RIGHT_BOTTOM,scale:(0.375,0.375));
				
				//8 rounds per row
				drawbar("UI_SMGam","UI_SMGsp",weapon.ammoCount,8,(-115,-36),0,SHADER_HORZ,DI_SCREEN_RIGHT_BOTTOM);
				drawbar("UI_SMGam","UI_SMGsp",weapon.ammoCount-8,8,(-115,-29),0,SHADER_HORZ,DI_SCREEN_RIGHT_BOTTOM);
				drawbar("UI_SMGam","UI_SMGsp",weapon.ammoCount-16,8,(-115,-22),0,SHADER_HORZ,DI_SCREEN_RIGHT_BOTTOM);
				drawbar("UI_SMGam","UI_SMGsp",weapon.ammoCount-24,8,(-115,-15),0,SHADER_HORZ,DI_SCREEN_RIGHT_BOTTOM);
			
				//spare ammo counter
				DrawString(mnewsmallfont, StringStruct.Format("\c[MarGreen]x%d ", ((ammoType1.amount)/(weapon.magazinesize))), (-97, -28.5),
                           DI_TEXT_ALIGN_LEFT|DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
			
			}
			
			//"Waste Em's"
			if (weapon is "MarShotgun_Weapon")
			{//StringStruct.Format("%d ", ((ammoType1.amount)/(weapon.magazinesize)))
				//drawimage("UI_44wep",(-30.5,-11.5),DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
				drawimage((weapon.secondarymode>0)?"UI_SGaki":"UI_SGwep",((weapon.secondarymode>0)?-47.:-50.5,-11.5),DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
				
				DrawString(mnewsmallfont,"\c[MarGreen]WSTE-M5 Combat Shotgun", (-65, -10),
                DI_TEXT_ALIGN_CENTER|DI_SCREEN_RIGHT_BOTTOM,scale:(0.375,0.375));
				
				//13 rounds per row
				drawbar("UI_SGam","UI_SGsp",weapon.ammoCount,2,(-63,-11),0,SHADER_REVERSE,DI_SCREEN_RIGHT_BOTTOM);
				if(weapon.secondarymode > 0)
					{drawbar("UI_SGam","UI_SGsp",weapon.ammoCount2,2,(-83,-11),0,SHADER_HORZ,DI_SCREEN_RIGHT_BOTTOM);}
					
				//spare ammo counter
				DrawString(mnewsmallfont, StringStruct.Format("\c[MarGreen]x%d ", ((ammoType1.amount)/(weapon.magazinesize))), (-135, -28.5),
                           DI_TEXT_ALIGN_LEFT|DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
			
			}
			
			//rl
			if (weapon is "MarRocketLauncher_Weapon")
			{//StringStruct.Format("%d ", ((ammoType1.amount)/(weapon.magazinesize)))
				//drawimage("UI_44wep",(-30.5,-11.5),DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
				drawimage("UI_RLwep",(-50.5,-16.5),DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
				
				DrawString(mnewsmallfont,"\c[MarGreen]SPNKR-XP SSM", (-65, -10),
                DI_TEXT_ALIGN_CENTER|DI_SCREEN_RIGHT_BOTTOM,scale:(0.375,0.375));
				
				drawbar("UI_RLam","UI_RLsp",weapon.ammoCount,2,(-110,-11),0,SHADER_HORZ,DI_SCREEN_RIGHT_BOTTOM);

				//spare ammo counter
				DrawString(mnewsmallfont, StringStruct.Format("\c[MarGreen]x%d ", ((ammoType1.amount)/(weapon.magazinesize))), (-135, -28.5),
                           DI_TEXT_ALIGN_LEFT|DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
			
			}
			
			//MarFusionPistol_Weapon
			if (weapon is "MarFusionPistol_Weapon")
			{//StringStruct.Format("%d ", ((ammoType1.amount)/(weapon.magazinesize)))
				//drawimage("UI_44wep",(-30.5,-11.5),DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
				drawimage("UI_FPwep",(-50.5,-9.5),DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
				
				DrawString(mnewsmallfont,"\c[MarGreen]Zeus Class Fusion Pistol", (-75, -10),
                DI_TEXT_ALIGN_CENTER|DI_SCREEN_RIGHT_BOTTOM,scale:(0.375,0.375));
				
				drawbar("UI_Barf","UI_Barh",weapon.ammoCount,20,(-100,-10),0,3,DI_SCREEN_RIGHT_BOTTOM);

				//spare ammo counter
				DrawString(mnewsmallfont, StringStruct.Format("\c[MarGreen]x%d ", ((ammoType1.amount)/(weapon.magazinesize))), (-135, -28.5),
                           DI_TEXT_ALIGN_LEFT|DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
			
			}
			
			//flamer
			if (weapon is "MarFlamethrower_Weapon")
			{//StringStruct.Format("%d ", ((ammoType1.amount)/(weapon.magazinesize)))
				//drawimage("UI_44wep",(-30.5,-11.5),DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
				drawimage("UI_FTwep",(-50.5,-9.5),DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
				
				DrawString(mnewsmallfont,"\c[MarGreen]TOZT-7 Napalm Unit", (-55, -10),
                DI_TEXT_ALIGN_CENTER|DI_SCREEN_RIGHT_BOTTOM,scale:(0.375,0.375));
				
				drawbar("UI_Barf","UI_Barh",weapon.ammoCount,210,(-100,-10),0,3,DI_SCREEN_RIGHT_BOTTOM);

				//spare ammo counter
				DrawString(mnewsmallfont, StringStruct.Format("\c[MarGreen]x%d ", ((ammoType1.amount)/(weapon.magazinesize))), (-135, -28.5),
                           DI_TEXT_ALIGN_LEFT|DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
			
			}
			
			if (weapon is "MarFist_Weapon")
			{
				drawimage("UI_Error",(-70.5,1.5),DI_SCREEN_RIGHT_BOTTOM,alpha:0.1,scale:(0.8,0.6),style:style_add);
				DrawString(mnewsmallfont,"\c[MarGreen]NO IMAGE", (-75, -30),
				DI_TEXT_ALIGN_CENTER|DI_SCREEN_RIGHT_BOTTOM,alpha:0.5,scale:(0.375,0.375));
				DrawString(mnewsmallfont,"\c[MarGreen]Steel Plated Knuckles", (-80, -10),
				DI_TEXT_ALIGN_CENTER|DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
			}
			
			if (weapon is "MarWaveMotionCannon_Weapon")
			{
				/*drawimage("UI_Error",(-70.5,1.5),DI_SCREEN_RIGHT_BOTTOM,alpha:0.1,scale:(0.8,0.6),style:style_add);
				DrawString(mnewsmallfont,"\c[MarGreen]CLASSIFIED", (-35, -30),
				DI_TEXT_ALIGN_CENTER|DI_SCREEN_RIGHT_BOTTOM,alpha:0.5,scale:(0.475,0.475));*/
				DrawString(mnewsmallfont,"\c[MarGreen]ONI-71 Wave Motion Cannon", (-75, -10),
                DI_TEXT_ALIGN_CENTER|DI_SCREEN_RIGHT_BOTTOM,scale:(0.375,0.375));
				
				drawimage("UI_WMCwp",(-55.5,-11.5),DI_SCREEN_RIGHT_BOTTOM,scale:(0.75,0.75));
				
				drawbar("UI_Barf","UI_Barh",weapon.ammoCount,weapon.magazineSize,(-126,-10),0,3,DI_SCREEN_RIGHT_BOTTOM);
			
				//spare ammo counter
				DrawString(mnewsmallfont, StringStruct.Format("\c[MarGreen]x%d ", ((ammoType1.amount)/(weapon.magazinesize))), (-115, -20.5),
                           DI_TEXT_ALIGN_LEFT|DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
			
			}
			
			if (weapon is "MarathonAlienWeapon")
			{//StringStruct.Format("%d ", ((ammoType1.amount)/(weapon.magazinesize)))
				//drawimage("UI_44wep",(-30.5,-11.5),DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
				drawimage("UI_Error",(-70.5,1.5),DI_SCREEN_RIGHT_BOTTOM,alpha:0.5,scale:(0.8,0.6),style:style_add);
				
				DrawString(mnewsmallfont,"\c[MarGreen]UNKNOWN WEAPON CLASS", (-95+(frandom(-0.1,0.1)), -30+(frandom(-0.1,0.1))),
                DI_TEXT_ALIGN_CENTER|DI_SCREEN_RIGHT_BOTTOM,scale:(0.375,0.375));
				DrawString(mnewsmallfont,"\c[MarGreen]system error 0xfded", (-95+(frandom(-0.1,0.1)), -20+(frandom(-0.1,0.1))),
                DI_TEXT_ALIGN_CENTER|DI_SCREEN_RIGHT_BOTTOM,scale:(0.375,0.375));
				
				DrawString(mnewsmallfont, StringStruct.Format("\c[MarGreen]x%d ", (ammoType1.amount)+((random(-150,5)*frandom(-1,1)))), (-115, -15.5),
                           DI_TEXT_ALIGN_LEFT|DI_SCREEN_RIGHT_BOTTOM,scale:(0.6,0.6));
						   
				//drawbar("UI_Barf","UI_Barh",ammoType1.amount+(random(-250,5)),250,(-126,-10),0,3,DI_SCREEN_RIGHT_BOTTOM);
			}
			
		}
		
	}
}