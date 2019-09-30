***********************************************
CABLES

Connect the tpad via USB cable to your computer. Also connect the tpad to power via the 24V power cable.

You don't need the 24V power cable to talk to the tpad, but you need it to power the piezos on the glass, 
so you won't be able to feel the haptic display until that's plugged in. I'd recommend being kind of careful 
with the cables-- always unplug them if you're going to move the tpad anywhere, and be gentle when 
plugging/unplugging-- the connectors are surface mount and we've had past trouble with them getting ripped 
off the board. 

***********************************************
CODE

Download all the files in the tpadAPI folder and run "exampleScript.m" in matlab. It should prompt you to 
select a port from a short list... you'll have to try all the port options until you find the right one. If 
successful, you should have a variable in your workspace called "dimensions" that equals [19200,5.3], and you 
should be able to feel a texture on the tpad display.

The script "exampleScript.m" demonstrates how to use the other three functions in the folder to:
   1. connect to the tpad(connect2tpad) 
   2. generate and load a friction pattern onto the tpad (loadData)
   3. record some finger position data for 5 seconds (getData) and then plot it. 
You can comment out everything past line 35 for now if you just want to load a pattern to make sure it works. 

When generating a friction pattern, I reccommend using the position array (x) built in line 14 of exampleScript. 
That way anytime you build a sinusoidal friction pattern using sin(2*pi*f*x), it will have the spatial period 1/f 
in millimeter units. E.g. a pattern sin(2*pi*3*x) would have a sticky band spaced every 1/3 mm.  

***********************************************
FILE MANAGEMENT
 
The files in the tpadAPI_v1.0 zip folder are the basic functions that you can use to communicate with the tpad. You'll 
need these functions in your path when calling them for more complicated projects.  You could just make sure all your 
code is in the same folder, but this can get messy and result in multiple copies of code everywhere and/or unorganized 
folders filled with tons of "v1, v2, v3 etc" of files. I usually just add a path to the tpadAPI folder so I can use it 
from anywhere: 
   addpath('C:/Users/User/Documents/MATLAB/tpadAPI_v1.0');
I run this line (plus a few more lines to link other code libraries) in a little startup script when I open matlab. 
Then I can use these functions from whatever local folder I'm in.

***********************************************




