#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Temperature IR Bricklet

# Set emissivity to 0.98 (emissivity of water, 65535 * 0.98 = 64224.299)
tinkerforge call temperature-ir-bricklet $uid set-emissivity 64224

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
tinkerforge call temperature-ir-bricklet $uid set-debounce-period 10000

# Handle incoming object temperature reached callbacks
tinkerforge dispatch temperature-ir-bricklet $uid object-temperature-reached\
 --execute "echo Object Temperature: {temperature}/10 °C. The water is boiling!" &

# Configure threshold for object temperature "greater than 100 °C"
tinkerforge call temperature-ir-bricklet $uid set-object-temperature-callback-threshold threshold-option-greater 1000 0

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
