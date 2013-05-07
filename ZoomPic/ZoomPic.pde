#include <MeggyJrSimple.h>    // Required code, line 1 of 2. 

byte xc,yc;             // Define two 8-bit unsigned variables for cursor position ('xc' and 'yc').
byte CurrentPxColor;    // Backup variable to store a color in.
byte ZoomColor;    
byte CursorPhase;       // Storage for state of cursor.

unsigned long LastTime;          // long variable for millisecond counter storage

#define DelayTime_ms  40        // creates delay time and makes it on and off

void setup()                    //setup
{

  MeggyJrSimpleSetup();      // Required code, line 2 of 2.
  
  ClearSlate();  //erase screen
  yc = 4;
  xc = 4;
  CurrentPxColor = 0;
  ZoomColor = 1;
  
  CursorPhase = 0;

  LastTime = millis(); //Returns Milliseconds COunter Values
    
}
