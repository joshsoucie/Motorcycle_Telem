/********************************************************************************
 * ADXL345 Library Examples- pitch_roll.pde                                      *
 *                                                                               *
 * Copyright (C) 2012 Anil Motilal Mahtani Mirchandani(anil.mmm@gmail.com)       *
 *                                                                               *
 * License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html> *
 * This is free software: you are free to change and redistribute it.            *
 * There is NO WARRANTY, to the extent permitted by law.                         *
 *                                                                               *
 *********************************************************************************/

// If you are working with Arduino Mega
// sudo ln -s /dev/ttyACM0 /dev/ttyS8

import processing.serial.*;

Serial fd;

int pitch = 0;
int roll = 0;
int heading = 0;
float newrotateX, newrotateY, newrotateZ = 0;

void setup () 
{
  size(800, 600, P3D); 
  //Connect to the corresponding serial port
  fd = new Serial(this, Serial.list()[2], 115200);
  // Defer callback until new line
  fd.bufferUntil('\n');
  
  noStroke();
  colorMode(RGB, 1);
}

void draw () 
{
  //Set background
  background(0.5);

  pushMatrix(); 
  translate(width/2, height/2, -30); 
/*
  newrotateX = (float)pitch*PI/180;
  newrotateY = (float)roll*PI/180;
  newrotateZ = (float)heading*PI/180;

  float diff = pitch-newrotateX;
  if (abs(diff)>0.01) {
    pitch = diff;
  }
  
  diff = roll-newrotateY;
  if (abs(diff)>0.01) {
    roll = diff;
  }
  
  diff = heading-newrotateZ;
  if (abs(diff)>0.01) {
    heading = diff;
  }
*/

  //Rotate
  rotateX((float)pitch*PI/180); 
  rotateZ((float)roll*PI/180);
  rotateY(-(float)heading*PI/180);

  //Print data
  print("Pitch: ");
  print(pitch);
  print(", Roll: ");
  print(roll);
  print(", Heading: ");
  println(heading);

  scale(90);
  fill(255,228,255);
  box(100,25,75);
  /*beginShape(QUADS);

  fill(0, 255, 0); vertex(-1,  1,  1);    //square #1
  fill(0, 255, 0); vertex( 1,  1,  1);
  fill(0, 255, 0); vertex( 1, -1,  1);
  fill(0, 255, 0); vertex(-1, -1,  1);

  fill(0, 255, 255); vertex( 1,  1,  1);    //square #2
  fill(0, 255, 255); vertex( 1,  1, -1);
  fill(0, 255, 255); vertex( 1, -1, -1);
  fill(0, 255, 255); vertex( 1, -1,  1);

  fill(255, 0, 255); vertex( 1,  1, -1);    //square #3
  fill(255, 0, 255); vertex(-1,  1, -1);
  fill(255, 0, 255); vertex(-1, -1, -1);
  fill(255, 0, 255); vertex( 1, -1, -1);

  fill(255, 255, 0); vertex(-1,  1, -1);    //square #4
  fill(255, 255, 0); vertex(-1,  1,  1);
  fill(255, 255, 0); vertex(-1, -1,  1);
  fill(255, 255, 0); vertex(-1, -1, -1);

  fill(255, 0, 0); vertex(-1,  1, -1);    //square #5
  fill(255, 0, 0); vertex( 1,  1, -1);
  fill(255, 0, 0); vertex( 1,  1,  1);
  fill(255, 0, 0); vertex(-1,  1,  1);

  fill(0, 0, 255); vertex(-1, -1, -1);    //square #6
  fill(0, 0, 255); vertex( 1, -1, -1);
  fill(0, 0, 255); vertex( 1, -1,  1);
  fill(0, 0, 255); vertex(-1, -1,  1);

  endShape();*/

  popMatrix();
}

void serialEvent (Serial fd) 
{
  // get the ASCII string:
  String rpstr = fd.readStringUntil('\n');
  if (rpstr != null) {
    String[] list = split(rpstr, '\t');
    //print("test: ", list[3]); //<>//
    pitch = ((int)float(list[0]));
    roll = ((int)float(list[1]));
    heading = ((int)float(list[2]));
  }
}