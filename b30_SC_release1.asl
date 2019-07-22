//SC IL autosplitter (easy and leg)
//by Burnt
	
state("halo") 
{
	uint tickcounter1: 0x2F1D8C; //pauses on pause menu, resets on reverts 
	float xpos: 0x2AC5BC; //chief camera x position
	float ypos: 0x2AC5C0; //chief camera y position
	float zpos: 0x2AC5C4; //chief camera z position
	byte chiefstate: 0x2AC5B4; //tracks whether chief in cutscene or vehicle
	uint buttonstate: 0x3FFE0344; //tracks whether button got pressed (specifically whether cutscene is done)
	byte bspstate: 0x29E8D8; //tracks which bsp is loaded
	byte pelistate: 0x3FFFAEA4; //tracks if final peli has spawned

	uint levelname: 0x319780;
}

startup //settings for which splits you want to use
{
settings.Add("hog", true, "split on hog");
settings.Add("intload", false, "split on interior load");
settings.Add("fling", true, "split on hog fling");
settings.Add("drop", false, "split on dropping to OS");
settings.Add("button", true, "split on pressing button");
settings.Add("stickstack", false, "split on stickstack launch");
settings.Add("extload", false, "split on exterior load");
settings.Add("pelispawn", true, "split on pelican spawn");

}

init
{
vars.indexoffset = 0;
}

start 	//starts timer
{
vars.indexoffset = 0;
return (current.tickcounter1 == 1093 && current.levelname == 1546662754); //starts timer on specific tick that chief hits the ground
}

split
{
int checkindex = timer.CurrentSplitIndex + vars.indexoffset;
	switch (checkindex)
	{
		case 0: //splits on entering hog
		if (!(settings["hog"]))
		{
		vars.indexoffset++;
		break;
		}
		return (current.chiefstate == 2);
		break;
		
		case 1: //splits on interior bsp load 
		if (!(settings["intload"]))
		{
		vars.indexoffset++;
		break;
		}
		return (current.bspstate == 1);
		break;

		case 2: //splits on hog fling
		if (!(settings["fling"]))
		{
		vars.indexoffset++;
		break;
		}
		return (current.ypos < -23.3);
		break;
		
		case 3: //splits on drop
		if (!(settings["drop"]))
		{
		vars.indexoffset++;
		break;
		}
		return (current.zpos < -14.2);
		break;
		
		case 4: //splits on button press (specfically as soon as you skip the cutscene)
		if (!(settings["button"]))
		{
		vars.indexoffset++;
		break;
		}
		return (current.buttonstate == 53280767);
		break;
		
		case 5: //splits on stickstack (shortly after you launch)
		if (!(settings["stickstack"]))
		{
		vars.indexoffset++;
		break;
		}
		return (current.buttonstate == 53280767 && current.zpos > -8.5);
		break;
		
		case 6: //splits on exterior bsp load 
		if (!(settings["extload"]))
		{
		vars.indexoffset++;
		break;
		}
		return (current.buttonstate == 53280767 && current.bspstate == 0);
		break;
		
		case 7: //splits on peli spawn
		if (!(settings["pelispawn"]))
		{
		vars.indexoffset++;
		break;
		}
		return (current.pelistate == 1);
		break;
		
		
		//TODO: add final split for pelican spawn
		
		default:	//splits on level end
		return (current.levelname == 1546663010);
		break;
	}
}

reset
{
return (current.tickcounter1 < 1050 && current.levelname == 1546662754);
}