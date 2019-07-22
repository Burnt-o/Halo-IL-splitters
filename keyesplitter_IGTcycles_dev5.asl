//Keyes Leg/Easy IL autosplitter  
//IGT VERSION (cycles)
		//Times IGT; each tick increments the timer by 1/30th of a second (switches to RTA when paused/alttabbed). This is a more accurate/consistent way to time.
		//Triggers internal splits when you are BOTH inside a trigger, AND when the trigger actually checks for the player (so it waits for the cycles)



	
state("halo") 
{
	uint tickcounter1: 0x2F1D8C; //pauses on pause menu, resets on reverts
	byte chiefstate: 0x2AC5B4; //tracks whether chief in cutscene or vehicle maybe
	byte otherstate: 0x2AC5B6; //some shite related to cutscenes
	string3 levelname: 0x319780; //should return d20 on keyes
	uint trigx: 0x00280274, 0x578, 0x238, 0x8, 0x744, 0xA0;
	uint trigy: 0x00280274, 0x578, 0x238, 0x8, 0x744, 0xA4;
	bool fadeflag: 0x3FF1581A; //0 when false, 1 when fading
	byte cutsceneskip: 0x3FFFD67A; //true when cutscene is skippable
	byte cutscenetrack: 0x29E8D8; //tracks which cutscene chief is in
	byte playercontrol: 0x2869D1; //tracks whether player has input control
	bool tickpaused: 0x325202; //tracks if tickcounter is paused
	byte difficultypointer: 0x296564; // 0, 1, 2, 3 for easy thru leg
	byte floodstateEasyNorm: 0x3FCC5603; //3 for flood standing, 1 for knocked down
	byte floodstateHero: 0x3FCC6563; //3 for flood standing, 1 for knocked down
	byte floodstateLeg: 0x3FCC74C3; //3 for flood standing, 1 for knocked down
	uint alteasyident: 0x3FCC595C;
	byte floodstateALTeasy: 0x3FCC58FF;
	uint altlegident: 0x3FCC781C;
	byte floodstateALTleg: 0x3FCC77BF;

	
}

startup //settings for which splits you want to use
{
settings.Add("floodspawn", true, "split on flood spawn");
settings.Add("flooddown", true, "split when flood is knocked");
settings.Add("floodup", true, "split when flood revives");
settings.Add("void trigger", true, "split on entering void trigger");
settings.Add("cutscene", true, "split on entering cutscene trigger");
settings.Add("cutscenestart", false, "split on cutscene starting");
settings.Add("section7", true, "split on entering section7 trigger");
settings.Add("7_1", true, "split on entering 7_1 trigger");
settings.Add("7_2", true, "split on entering 7_2 trigger");



}

init
{
	vars.indexoffset = 0;
	vars.isLoadingFlag = true;	
	vars.tickdifference = 0;
	vars.tickcounterlocal = 0;
	vars.getreadyvoid = false;
	vars.tickat7u1 = 0;
	vars.specialfix = false;
	vars.resetticks = 0;
	vars.lockedon = false;
	vars.needtoscan = false;
	vars.floodwasknocked = false;
	vars.floodstate = 0;
	vars.testvalue = "hi";
}

start 	//starts timer
{
vars.testvalue = "hello";
vars.floodstate = 0;
vars.needtoscan = false;
vars.floodwasknocked = false;
vars.lockedon = false;
vars.indexoffset = 0;
vars.resetticks = 0;
return (current.tickcounter1 >= 0 && current.cutsceneskip != 1 && current.tickcounter1 < 15 && current.levelname == "d20"); //starts timer as soon as cutscene is skipped, I think
}

split
{

 




int checkindex = timer.CurrentSplitIndex + vars.indexoffset;
	switch (checkindex)
	{
		case 0: 
		if (!(settings["floodspawn"]))
		{
		vars.indexoffset++;
		break;
		}
		return (current.trigx >= 1106794570 && current.tickcounter1 % 5 == 0 && current.trigy > 3212836864);
		break;

		case 1:
		if (!(settings["flooddown"]))
		{
		vars.indexoffset++;
		break;
		}


		int diffcheck = current.difficultypointer;
			switch (diffcheck)
			{
			case 0:  
			case 1:
			//print ("alteasyident is" + current.alteasyident);
			if (current.alteasyident == 16777473)
			{
				if (current.floodstateALTeasy == 1)
				{
				vars.floodwasknocked = true;
				return true;
				}
			}
			else
			{
				if (current.floodstateEasyNorm == 1)
				{
				vars.floodwasknocked = true;
				return true;
				}
			}
			break;
			
			case 2:
				if (current.floodstateHero == 1)
				{
				vars.floodwasknocked = true;
				return true;
				}
			break; 
			
			case 3:
			if (current.altlegident == 16777473)
			{
				if (current.floodstateALTleg == 1)
				{
				vars.floodwasknocked = true;
				return true;
				}
			}
			else
			{
				if (current.floodstateLeg == 1)
				{
				vars.floodwasknocked = true;
				return true;
				}
			}
			break;
			}
		break;
		
		
		
		
		
		case 2: 
		if (!(settings["floodup"]))
		{
		vars.indexoffset++;
		break;
		}
		if (vars.floodwasknocked == true)
			{

				int diffcheck2 = current.difficultypointer;
				switch (diffcheck2)
					{
					case 0:  
					case 1:
					//print ("alteasyident is" + current.alteasyident);88
					if (current.alteasyident == 16777473)
					{
						return (current.floodstateALTeasy == 3);
						break;
					}
					else
					{
						return (current.floodstateEasyNorm == 3);
						break;
					}
					
					case 2:
						return (current.floodstateHero == 3);
					break; 
					
					case 3:
					if (current.altlegident == 16777473)
					{
						return (current.floodstateALTleg == 3);
						break;
					}
					else
					{
						return (current.floodstateLeg == 3);
						break;
					}
					}
			}
			else
			{
						int diffcheck3 = current.difficultypointer;
						switch (diffcheck3)
						{
						case 0:  
						case 1:
						//print ("alteasyident is" + current.alteasyident);
						if (current.alteasyident == 16777473)
						{
							if (current.floodstateALTeasy == 1)
							{
							vars.floodwasknocked = true;
							}
						}
						else
						{
							if (current.floodstateEasyNorm == 1)
							{
							vars.floodwasknocked = true;
							}
						}
						break;
						
						case 2:
							if (current.floodstateHero == 1)
							{
							vars.floodwasknocked = true;
							}
						break; 
						
						case 3:
						if (current.altlegident == 16777473)
						{
							if (current.floodstateALTleg == 1)
							{
							vars.floodwasknocked = true;
							}
						}
						else
						{
							if (current.floodstateleg == 1)
							{
							vars.floodwasknocked = true;
							}
						}
						break;
						}
			}
		break;
		
		case 3:  
		if (!(settings["void trigger"]))
		{
		vars.indexoffset++;
		break;
		}
		return (current.trigy <= 3266829312 && current.tickcounter1 % 30 == 3 && current.trigy > 3212836864);
		break;
		
		case 4: 
		if (!(settings["cutscene"]))
		{
		vars.indexoffset++;
		break;
		}
		return (current.trigx >= 1102276414 && current.trigy >= 3268097934 && current.tickcounter1 % 30 == 5);
		break;
		
		case 5: 
		if (!(settings["cutscenestart"]))
		{
		vars.indexoffset++;
		break;
		}
		return (current.fadeflag == true);
		break;
		
		case 6: 
		if (!(settings["section7"]))
		{
		vars.indexoffset++;
		break;
		}
		return (current.trigy <= 3266394568 && current.tickcounter1 % 5 == 3 && current.trigy > 3212836864);
		break;
		
		case 7:
		if (!(settings["7_1"]))
		{
		vars.indexoffset++;
		break;
		}
		if (current.trigx <= 1072275462 && current.tickcounter1 % 5 == 4 && current.trigy > 3212836864)
			{
			vars.tickat7u1 = current.tickcounter1; //this stuff is prep stuff to align correct cycle for 7_2 split
				if (vars.tickat7u1 % 30 == 29)
				{
				vars.specialfix = true;
				}
				else
				{
				vars.specialfix = false;
				}
			return true;
			}
		break;
		
		case 8: 
		if (!(settings["7_2"]))
		{
		vars.indexoffset++;
		break;
		}
		if (!(settings["7_1"])) //duplicating 7_1s important prep stuff if 7_1 split is disabled
		{
				if (current.trigx <= 1072275462 && current.tickcounter1 % 5 == 4 && current.trigy > 3212836864)
					{
					vars.tickat7u1 = current.tickcounter1;
						if (vars.tickat7u1 % 30 == 29)
							{ 
							vars.specialfix = true;
							}
							else
							{
							vars.specialfix = false;
							}
					}
		}
		
		
		//print ("vars.tickat7u1 is " + vars.tickat7u1);
		//print ("((vars.tickat7u1 % 30) + 1) is " + ((vars.tickat7u1 % 30) + 1));
		//print ("vars.specialfix is" + vars.specialfix);
		//btw the special fix stuff is a bandaid related to me not be good at modulo maths
		
		//actual 7_2 logic (yeah, it's jank but should work fine)
		return (current.trigy > 3212836864 && current.trigy <= 3265091578 && ((current.tickcounter1 % 30 == ((vars.tickat7u1 % 30) + 1)) || (vars.specialfix && (current.tickcounter1 % 30 == 0))));
		break;


		
		default:	//splits on full white. well technically on the beginning of the cutscene after fullwhite which happens about 3 ticks later and with a more consistent timing
		return (current.chiefstate == 2 && current.otherstate == 2);
		break;
	}
}

gameTime
{		

		if ((current.tickcounter1 - old.tickcounter1) > 0)
		{
			return (TimeSpan.FromSeconds((current.tickcounter1 + vars.resetticks) / 30.0f)); 
		}
		//else if (!(settings["revert"]))
		//{
		//vars.resetticks += old.tickcounter1 - current.tickcounter1;
		//}
		
		
}


isLoading
{ 
return true;
}

reset
{
return (current.cutsceneskip == 1);
}