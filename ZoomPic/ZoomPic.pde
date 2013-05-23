#include <MeggyJrSimple.h>    // Required code, line 1 of 2. 

//Cursor Code before and in setup is from MeggyBrite example

byte xc,yc;             // Define two 8-bit unsigned variables for cursor position ('xc' and 'yc'). 
byte CurrentPxColor;    // Backup variable to store a color in. 
byte ZoomColor;          // Cursor Color from MeggyBrite example
boolean flash;       // Storage for state of cursor.
int ZoomLevel;       //Creates the zoom

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
  
  flash = false;

  LastTime = millis(); //Returns Milliseconds COunter Values 
  for (int x = 2; x < 6; x++) //Creates picture 
    DrawPx(x,6,1);
  for (int x = 2; x < 6; x++)
    DrawPx(x,2,1);
  for (int y = 2; y < 6; y++)
    DrawPx(6,y,1);
  for (int y = 2; y < 6; y++)
    DrawPx(2,y,1);
} 
  
void loop() //repeating part
{
  
  
  //Cursor Code Begins here
  DisplaySlate(); //Displays
  if (flash) DrawPx(xc,yc,White); //Affects how much the cursor blinks
  else DrawPx(xc,yc,0);
  flash = !flash; 

  
  //This applies to the southwest quadrant
  

  
  CheckButtonsPress(); //check to see if buttons have been pressed
  
  if (Button_A)
  {
    Serial.println("Button A pressed"); //Makes the A button show up in monitor mode
                   //Makes a button zoom in    
    
    Tone_Start(ToneE3, 50);
    if (xc < 4 && yc < 4) //Southwest Quadrant zoom starts here 
         zoomSW(); 
          
     
      //Southwest Quadrant zoom ends here
    if (xc < 4 && yc > 4)//northwest quadrant starts here
        zoomNW();
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
  
 
 void zoomSW() //own method
{
  
  for (int i = 0; i < 8; i++) //Selects whole board
  {
    for (int j = 0; j < 8; j++) 
    {
      if (ReadPx(i,j) != 0 && (xc != i || yc != j)) // is not cursor and is not black
      {
        if (i < 4 && j < 4) //Selects SW quadrant, changes with each quadrant
        { //This only works for ONE point
          DrawPx(2*i,2*j,Green);  //Moves dot to new point in the whole meggy
          DrawPx(2*i,2*j+1,Green); //Moves dot to new point in the whole meggy
          DrawPx(2*i+1,2*j+1,Green); //Moves dot to new point in the whole meggy
          DrawPx(2*i+1,j*2,Green);  //Moves dot to new point in the whole meggy
        }
        if (ReadPx(i,j) != Green)
          DrawPx(i,j,0);
      }
    }
  }
  for (int i = 0; i < 8; i++) //Selects whole board
  {
    for (int j = 0; j < 8; j++) //
    {
      if (ReadPx(i,j) == Green)
        DrawPx(i,j,12);
    }
  }
}





 void zoomNE() //own method
 {
  
  for (int i = 0; i < 8; i++) //Selects whole board
  {
    for (int j = 0; j < 8; j++) //selects whole board
    {
      if (ReadPx(i,j) != 0 && (xc != i || yc != j)) // is not cursor and is not black
      {
        if (i > 3 && j > 3) //Selects NW quadrant, changes with each quadrant
        { //This only works for ONE point
          DrawPx(2*i,j,Green);  //CHANGES
          DrawPx(2*i,j-1,Green); //CHANGES
          DrawPx(2*i+1,j-1,Green); //CHANGES
          DrawPx(2*i+1,j,Green);  //CHANGES
        }
        if (ReadPx(i,j) != Green)
          DrawPx(i,j,0);
      }
    }
  }
  for (int i = 0; i < 8; i++) //Selects whole board
  {
    for (int j = 0; j < 8; j++) //
    {
      if (ReadPx(i,j) == Green)
        DrawPx(i,j,12);
    }
  }
 } 

 void zoomNW() //own method
 {
  
  for (int i = 0; i < 8; i++) //Selects whole board
  {
    for (int j = 0; j < 8; j++) //selects whole board
    {
      if (ReadPx(i,j) != 0 && (xc != i || yc != j)) // is not cursor and is not black
      {
        if (i < 4 && j > 3) //Selects NW quadrant, changes with each quadrant
        { //This only works for ONE point
          DrawPx(2*i,j,Green);  //CHANGE THIS
          DrawPx(2*i,j-1,Green); //CHANGE THIS
          DrawPx(2*i+1,j-1,Green); //
          DrawPx(2*i+1,j,Green);  //
        }
        if (ReadPx(i,j) != Green)
          DrawPx(i,j,0);
      }
    }
  }
  for (int i = 0; i < 8; i++) //Selects whole board
  {
    for (int j = 0; j < 8; j++) //
    {
      if (ReadPx(i,j) == Green)
        DrawPx(i,j,12);
    }
  }
 } 




