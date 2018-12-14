package main

import (
	"fmt"
	"tinkerforge/ipconnection"
	"tinkerforge/temperature_ir_bricklet"
)

const ADDR string = "localhost:4223"
const UID string = "XYZ" // Change XYZ to the UID of your Temperature IR Bricklet.

func main() {
	ipcon := ipconnection.New()
	defer ipcon.Close()
	tir, _ := temperature_ir_bricklet.New(UID, &ipcon) // Create device object.

	ipcon.Connect(ADDR) // Connect to brickd.
	defer ipcon.Disconnect()
	// Don't use device before ipcon is connected.

	// Get current ambient temperature.
	ambientTemperature, _ := tir.GetAmbientTemperature()
	fmt.Printf("Ambient Temperature: %f °C\n", float64(ambientTemperature)/10.0)

	// Get current object temperature.
	objectTemperature, _ := tir.GetObjectTemperature()
	fmt.Printf("Object Temperature: %f °C\n", float64(objectTemperature)/10.0)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
