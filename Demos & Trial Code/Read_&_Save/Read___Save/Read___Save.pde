import processing.serial.*;

Serial fd;

float t=0;
int pitch, roll, yaw = 0;
String filepath;
Table table;

void setup()
{
  size(800,600,P3D);
  //Connect to the appropriate Serial Port
  fd = new Serial(this, Serial.list()[2], 115200);
  // Defer callback until new line
  fd.bufferUntil('\n');
  
  // Setup Table where information will be stored before writing
  table = new Table();
  
  table.addColumn("t=");
  table.addColumn("p_ang");
  table.addColumn("r_ang");
  table.addColumn("y_ang");
  
  // Will add functionality to store x,y,&z displacement at a later date.
  /*
  table.addColumn("x_dis");
  table.addColumn("y_dis");
  table.addColumn("z_dis");
  */
  
}

void draw () 
{
  while (t > 0) {
  //Print data
  print("t= ");
  print(t);
  print(", P: ");
  print(pitch);
  print(", R: ");
  print(roll);
  print(", H: ");
  println(yaw);
  
  // Create a new Row
  TableRow row = table.addRow();
  // Add values to Row
  row.setFloat("t=", t);
  row.setFloat("p_ang", pitch);
  row.setFloat("r_ang", roll);
  row.setFloat("y_ang", yaw);
  
  filepath = "Data/test.csv";
  
  // Save the table to a file
  saveTable(table, filepath, "csv");
  }
}

void serialEvent (Serial fd) 
{
  // get the ASCII string:
  String rpstr = fd.readStringUntil('\n');
  if (rpstr != null) {
    String[] list = split(rpstr, '\t');
    //print("test: ", list[3]);
    t = (float(list[0]));
    pitch = ((int)float(list[1]));
    roll = ((int)float(list[2]));
    yaw = (-(int)float(list[3]));
  }
}