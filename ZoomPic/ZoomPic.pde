#include <MeggyJrSimple.h>    // Required code, line 1 of 2. 

//Cursor Code before and in setup is from MeggyBrite example

byte xc,yc;             // Define two 8-bit unsigned variables for cursor position ('xc' and 'yc'). 
byte CurrentPxColor;    // Backup variable to store a color in. 
byte ZoomColor;          // Cursor Color from MeggyBrite example
int CursorPhase;       // Storage for state of cursor.

unsigned long LastTime;          // long variable for millisecond counter storage

#define DelayTime_ms  40        // creates delay time and makes it on and off

void setup()                    //setup
{
  
  Serial.begin(9600);
  MeggyJrSimpleSetup(); //required code, 2 of 2
  
  ClearSlate();  //erase screen
  yc = 4;
  xc = 4;
  CurrentPxColor = 0;
  ZoomColor = 1;
  
  CursorPhase = 0;

  LastTime = millis(); //Returns Milliseconds COunter Values 
} 
  
void loop() //repeating part
{
  //Cursor Code Begins here
  DisplaySlate(); //Displays
  delay(100); //Delay of cursor
  ClearSlate();   //clears cursor
  CursorPhase++;  //INcrease cursor slate by 1 
  if (CursorPhase > 10) CursorPhase = 1; //Affects how much the cursor blinks
  DisplaySlate(); //dsiplays cursor
  Serial.println(CursorPhase); //Makes cursor show up in the monitor mode
  if (CursorPhase % 2 == 0) DrawPx(xc,yc,White); //This affects how often the cursor blinks
  //Cursor Code ends here
  
  //This creates the South West Quadrant
  for (int i = 0; i < 4; i++)
  for (int j = 0; j < 4; j++)
  {
    if (ReadPx(i,j) != 0)
    {
      DrawPx(2*i,2*j,12);  //Draws the coordinates around the point, Doesn't move the dot to the new part
      DrawPx(2*i,2*j+1,12);
      DrawPx(2*i+1,2*j+1,12);
      DrawPx(2*i+1,j*2,12);
    }
  }
  
  CheckButtonsPress(); //check to see if buttons have been pressed
  
  if (Button_A)
  {
    Serial.println("Button A pressed"); //Makes the A button show up in monitor mode
    //if ReadPx(i,j != 0)                 //Makes a button zoom in    
    
    Tone_Start(ToneE3, 50);
  }
   if (Button_Up)       // Move Cursor Up
  {    
    DrawPx(xc,yc,CurrentPxColor);      // Write "real" color to current pixel in the game buffer.
    Serial.println("Button Up pressed"); 
    if (yc < 7)
      yc++;
    else
      yc = 0;     // Wrap around at edges   

    CurrentPxColor = ReadPx(xc,yc);    // Store "real" value of new current pixel.
    
      Tone_Start(ToneE3, 50);
    
  }
  
  if (Button_Down)       // Move Cursor Down
  {    
    DrawPx(xc,yc,CurrentPxColor);      // Write "real" color to current pixel in the game buffer.
    Serial.println("Button Up pressed");
    if (yc > 0)
      yc--;
    else
      yc = 7;      // Wrap around at edges   
    CurrentPxColor = ReadPx(xc,yc);    // Store "real" value of new current pixel.
    
      Tone_Start(ToneFs3, 50);
  }


  if (Button_Right)       // Move Cursor Right
  {    
    DrawPx(xc,yc,CurrentPxColor);      // Write "real" color to current pixel in the game buffer.
    Serial.println("Button Right pressed");
    if (xc < 7)
      xc++;
    else
      xc = 0;      // Wrap around at edges   
    CurrentPxColor = ReadPx(xc,yc);    // Store "real" value of new current pixel.
    
      Tone_Start(ToneA3, 50);
  }

  if (Button_Left)       // Move Cursor Right 
  {    
    DrawPx(xc,yc,CurrentPxColor);      // Write "real" color to current pixel in the game buffer.
    Serial.println("Button Left pressed");
    if (xc > 0)
      xc--;
    else
      xc = 7;      // Wrap around at edges   
    CurrentPxColor = ReadPx(xc,yc);    // Store "real" value of new current pixel.
      Tone_Start(ToneB3, 50);
  }
} 
  




