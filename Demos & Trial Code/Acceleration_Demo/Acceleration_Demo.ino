/********************************************************************
* Copyright (C) 2011 - 2014 Bosch Sensortec GmbH
*
* Usage: Example code to stream Accelerometer data
*
* License:
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright
* notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
* notice, this list of conditions and the following disclaimer in the
* documentation and/or other materials provided with the distribution.
* Neither the name of the copyright holder nor the names of the
* contributors may be used to endorse or promote products derived from
* this software without specific prior written permission.
*
* The information provided is believed to be accurate and reliable.
* The copyright holder assumes no responsibility for the consequences of use
* of such information nor for any infringement of patents or
* other rights of third parties which may result from its use.
* No license is granted by implication or otherwise under any patent or
* patent rights of the copyright holder.
*/

//Contains the bridge code between the API and the Arduino Environment
#include "NAxisMotion.h"
#include <Wire.h>

//Object that for the sensor
NAxisMotion mySensor;

//To store the last streamed time stamp
unsigned long lastStreamTime = 0;

//To stream at 25Hz without using additional timers
//(time period(ms) =1000/frequency(Hz))
const int streamPeriod = 40;

//Flag to update the sensor data
//Default is true to perform the first read before the first stream
bool updateSensorData = true;

//This code is executed once
void setup() {
	//Peripheral Initialization

	//Initialize the Serial Port
	//to view information on the Serial Monitor
	Serial.begin(115200);
	
	//Initialize I2C communication to the let the
	//library communicate with the sensor. 
	I2C.begin();
	
	//Sensor Initialization
	//The I2C Address can be changed here
	//inside this function in the library
	mySensor.initSensor();

	//Can be configured to other operation modes as desired
	mySensor.setOperationMode(OPERATION_MODE_NDOF);

	//The default is AUTO
	//Changing to manual requires calling the relevant
	//update functions prior to calling the read functions
	mySensor.setUpdateMode(MANUAL);
	//Setting to MANUAL requires lesser reads to the sensor
	
	mySensor.updateAccelConfig();
	updateSensorData = true;
	
	Serial.println();
	Serial.println("Default accelerometer configuration settings...");
	Serial.print("Range: ");
	Serial.println(mySensor.readAccelRange());
	Serial.print("Bandwidth: ");
	Serial.println(mySensor.readAccelBandwidth());
	Serial.print("Power Mode: ");
	Serial.println(mySensor.readAccelPowerMode());
	
	//Countdown
	Serial.println("Streaming in ...");
	Serial.print("3...");
	delay(1000);	//Wait for a second
	Serial.print("2...");
	delay(1000);	//Wait for a second
	Serial.println("1...");
	delay(1000);	//Wait for a second
}

void loop() { //This code is looped forever
	//Keep the updating of data as a separate task
	if (updateSensorData) {
		//Update the Accelerometer data
		mySensor.updateAccel();
		
		//Update the Linear Acceleration data
		mySensor.updateLinearAccel();
		
		//Update the Gravity Acceleration data
		mySensor.updateGravAccel();
		
		//Update the Calibration Status
		mySensor.updateCalibStatus();
		updateSensorData = false;
	}
	if ((millis() - lastStreamTime) >= streamPeriod) {
		lastStreamTime = millis();

		Serial.print("Time: ");
		Serial.print(lastStreamTime);
		Serial.print("ms ");

		//Accelerometer X-Axis data
		Serial.print(" aX: ");
		Serial.print(mySensor.readAccelX());
		Serial.print("m/s2 ");

		//Accelerometer Y-Axis data
		Serial.print(" aY: ");
		Serial.print(mySensor.readAccelY());
		Serial.print("m/s2 ");

		//Accelerometer Z-Axis data
		Serial.print(" aZ: ");
		Serial.print(mySensor.readAccelZ());
		Serial.print("m/s2 ");

		//Linear Acceleration X-Axis data
		Serial.print(" lX: ");
		Serial.print(mySensor.readLinearAccelX());
		Serial.print("m/s2 ");

		//Linear Acceleration Y-Axis data
		Serial.print(" lY: ");
		Serial.print(mySensor.readLinearAccelY());
		Serial.print("m/s2 ");

		//Linear Acceleration Z-Axis data
		Serial.print(" lZ: ");
		Serial.print(mySensor.readLinearAccelZ());
		Serial.print("m/s2 ");

		//Gravity Acceleration X-Axis data
		Serial.print(" gX: ");
		Serial.print(mySensor.readGravAccelX());
		Serial.print("m/s2 ");

		//Gravity Acceleration Y-Axis data
		Serial.print(" gY: ");
		Serial.print(mySensor.readGravAccelY());
		Serial.print("m/s2 ");

		//Gravity Acceleration Z-Axis data
		Serial.print(" gZ: ");
		Serial.print(mySensor.readGravAccelZ());
		Serial.print("m/s2 ");

		//Accelerometer Calibration Status (0 - 3)
		Serial.print(" C: ");
		Serial.print(mySensor.readAccelCalibStatus());

		Serial.println();
		updateSensorData = true;
	}
}
