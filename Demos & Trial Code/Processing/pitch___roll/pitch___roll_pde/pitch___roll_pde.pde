import processing.serial.*;
import processing.opengl.*;

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
  
  smooth();
}


void draw () 
{
  translate(width/2, height/2, -30); 

  //Rotate
  rotateX(-(float)pitch*PI/180); 
  rotateZ(-(float)roll*PI/180);
  rotateY(-(float)heading*PI/180);

  //Set background
  background(255);
  fill(0,0,255);
  box(150,50,200);

  //Print data
  print("P: ");
  print(pitch);
  print(", R: ");
  print(roll);
  print(", H: ");
  println(heading);

  //scale(90);


}

void serialEvent (Serial fd) 
{
  // get the ASCII string:
  String rpstr = fd.readStringUntil('\n');
  if (rpstr != null) {
    String[] list = split(rpstr, '\t');
    //print("test: ", list[3]);
    pitch = ((int)float(list[1]));
    roll = ((int)float(list[0]));
    heading = ((int)float(list[2]));
  }
}