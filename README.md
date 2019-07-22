# Halo-IL-splitters
Livesplit autosplitters for individual level speedruns in Halo CE, by Burnt

If you have any issues, or suggestions on more internal splits or other features to add, let me know on discord @BurntKurisu#6253

# --INSTALLATION--
To use one of these autosplitters, open up livesplit, then right click on the livesplit window -> edit layout. Hit the big plus (+) button, -> Control -> Scriptable Auto Splitter. It doesn't matter where in your layout hierarchy it is, but you must double click on it to open up it's settings. In the "script path" field, browse to the .asl file you want to use. 

All autosplitters have options for what internal splits you want to use. Select what you want by ticking and unticking them in the Scriptable Auto Splitters settings, then after accepting, right click on the livesplit window -> edit splits; add the splits you want, giving them whatever names you like. The amount of splits you'll want is however many you ticked in the options + 1 (for the end of the level).

If you're having issues getting it working, try: right click on your livesplit window, go to "Compare Against", and make sure it's set to "Real Time". (unless you're using the KeyesIGT or KeyesIGTcycles autosplitters, then you want it set to "Game Time")

# Change Log
- 23/08/2019 -
  * Added autosplitter for Two Betrayals
  * Finally started hosting everything together on GitHub


# Known issues:
Keyes splitters:
  *Timer will start at the intro cutscene and then reset when you skip it, doubling your attempt count.
  *IGT timers pause if you open up the pause menu or alt tab. Kind of good tho.
  *Will definitely break if you take a weird route like fullpath keyes or something.
  *Timer can start at weird times like the mainmenu or when exiting the game.
  *IGTc has issues around section7/7_1 like possibly splitting when it's not actually the cycle.


# Some notes on the Keyes splitters:
There's 3 autosplitters. What's the difference between them?
---keyesplitter_RTA:---
RTA (real time attack) timer that works like other autosplitters you've likely used before. The internal splits work by splitting as soon as you enter the trigger volume. This is the one you want to use as your "real" timer, though it could be worth manually retiming for very close/fast times; I made the ending split a little late to be conservative, the code is set to split as soon as the end cutscene starts as opposed to at a specific frame of fullwhite. 

---keyesplitter_IGT---
This timer takes the in-game tick counter (the game ideally tries to run at 30 ticks per second) and sets 
its timer to that (ticks divided by 30). Like in the RTA timer though, the internal splits will split as 
soon as you enter the trigger volume. This timer isn't very useful on it's own, but is quite useful when 
compared to the final timer.

---keyesplitter_IGTcycles---
The timer works the same as the IGT one, but the way the internal splits activate is different. Instead of splitting as soon as you enter the relevant trigger volume, it will wait after you enter until the specific tick cycle that the trigger checks for your presence on. Compare this to the previous timer to find how close you were to making the next cycle or not. When you make new cycles, you will gold this timer. You should check this timer mid-run (eg during the cutscene) to see if you're on pace for a specific time or not.
The exception (not just for IGTcycles but for all of them) to triggering on entering trigger volumes are the floodup/flooddown splits. They don't wait for a cycle, and don't have an associated trigger volume (duh)

---
If you want to have all 3 Keyes timers running at once, save your layouts as 3 seperate livesplitlayout (.lsl) files with the script paths set to the right autosplitter file for each. You will also need to save 3 seperate split files (.lss). Open all 3 of those .lsl files when you want to do some keyes runs. 



