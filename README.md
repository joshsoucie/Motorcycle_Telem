# Motorcycle_Telem


This project is set to be a collection of various telemetry data for motorcycles. Motorcycle telemetry is expensive.
This seeks to provide an open-source solution to anyone wishing to implement on their motorcycles. Hopefully, it would
be possible to provide ready-programmed, plug and play solutions for sale in the future.

The idea is to capture data such as:
  Speed
  Forward/Rearward acceleration
  Lean Angle
  Throttle Position
  Braking
  Front Left/Right Suspension Velocity
  Front Left/Right Suspension Acceleration
  Rear Suspension Velocity
  Rear Suspension Acceleration
  
Hardware currently being used for this application:
  Raspi 3: Serve as central data server (large MicroSD, running LAMP server over wifi)
  ESP8266: Serve as lower-powered data capture hardware, set data to raspi
  MPU6050: Serve as accelerometer
  
