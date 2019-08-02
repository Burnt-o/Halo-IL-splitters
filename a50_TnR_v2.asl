//Credit Burnt, took a ton from his past work
//AOTCR Leg IL autosplitter 

//easy splits
//bsp load to banshee grab 
//getting into banshee
//1st button press
//2nd button press
//opening hallway start door
//opening hallway end door
//1st tele complete
//2nd tele complete
//end
//chief header, 2AC560
// camo, lift, belly cp, bridge open, prison cutscene, end cutscene

	
state("halo") 
{
	uint tickcounter1: 0x2F1D8C; //pauses on pause menu, resets on reverts 
	float xpos: 0x2AC5BC; //chief camera x position
	float ypos: 0x2AC5C0; //chief camera y position
	float zpos: 0x2AC5C4; //chief camera z position
	byte chiefstate: 0x2AC5B4; //tracks whether chief in cutscene or vehicle
	byte levelname: 0x319780;
	byte camo: 0x3FE57875;
	byte lift: 0x3FFE1580; //upon first triggering lift script, 254 until inside volume
	bool belly: 0x08EC46D2; //upon trigger volume after belly
	byte bridge: 0x403E73D3; //64 when door unlocked
	byte fade: 0x3FF1581A; //1 if fading
	byte cutsceneskip: 0x3FFFD67A; //true when cutscene is skippable
	byte doorstate: 0x3FFEA242; //bridge door state

}

startup //settings for which splits you want to use
{
settings.Add("camo", true, "split on picking up camo");
settings.Add("lift", true, "split on wave fight start");
settings.Add("liftend", true, "split on cutscene going up");
settings.Add("belly", true, "split on turning left after belly"); //subject to change
settings.Add("bridge", true, "split past unlocked bridge door");
settings.Add("prison", true, "split on prison cutscene");
settings.Add("end", true, "split on next level");
}

init
{
vars.indexoffset = 0;
}

start 	//starts timer
{
vars.indexoffset = 0;
return (current.tickcounter1 == 850); //starts timer on specific tick that chief gets movement
}

split
{
int checkindex = timer.CurrentSplitIndex + vars.indexoffset;
	switch (checkindex)
	{
		case 0: //splits on camo grab
		if (!(settings["camo"]))
		{
		vars.indexoffset++;
		break;
		}
//		return (95 < current.zpos && 105 > current.zpos && 18 < current.ypos && 23 > current.ypos && -2 < current.xpos && 0 > current.xpos);
		return (current.camo == 1);
		break;

		case 1: //splits on lift trigger volume
		if (!(settings["lift"]))
		{
		vars.indexoffset++;
		break;
		}
		return (90 < current.zpos && 105 > current.zpos && 13 < current.ypos && 33 > current.ypos && 12 < current.xpos && 32 > current.xpos);
		break;
		
		case 2: //splits on into ship
		if (!(settings["liftend"]))
		{
		vars.indexoffset++;
		break;
		}
//		return (current.zpos < 90);
		return (old.cutsceneskip == 0 && current.cutsceneskip == 1);
		break;

		case 3: //splits on trigger volume turning left after belly skip
		if (!(settings["belly"]))
		{
		vars.indexoffset++;
		break;
		}
		return (-25 < current.zpos && -18 > current.zpos && -5 < current.ypos && 0 > current.ypos && 22 < current.xpos && 28 > current.xpos);
		break;
		
		case 4: //splits on second button
		if (!(settings["bridge"]))
		{
		vars.indexoffset++;
		break;
		}
//		return (-25 < current.zpos && -14 > current.zpos && -65 < current.ypos && -55 > current.ypos && -14 < current.xpos && -5 > current.xpos);
		return (current.doorstate == 255);
		break;
		
		case 5: //splits on prison scene
		if (!(settings["prison"]))
		{
		vars.indexoffset++;
		break;
		}
		return (current.fade == 1 && current.ypos < -100);
		break;
		
		default:	//splits on level end
		//return (current.levelname == 98);
		return (old.fade == 1 && current.fade == 0);
		break;
	}
}

reset
{
return (current.tickcounter1 < 850 && current.levelname == 97);
}