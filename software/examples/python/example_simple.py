#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_temperature_ir import TemperatureIR

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    tir = TemperatureIR(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get current ambient temperature (unit is °C/10)
    ambient_temperature = tir.get_ambient_temperature()
    print('Ambient Temperature: ' + str(ambient_temperature/10.0) + ' °C')

    # Get current object temperature (unit is °C/10)
    object_temperature = tir.get_object_temperature()
    print('Object Temperature: ' + str(object_temperature/10.0) + ' °C')

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
