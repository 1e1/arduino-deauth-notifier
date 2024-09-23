#!/bin/bash

# Search for the Arduino's serial device
serial_device=$(ls /dev/ttyACM* /dev/ttyUSB* | grep -m 1 'ACM\|USB' || echo "No device found")

# Check if a device was found
if [[ $serial_device != "No device found" ]]; then
    # Open the serial device with a baud rate of 9600
    stty -F $serial_device 9600

    # Read data from the serial device in a loop
    while true; do
        # Read a line of data from the serial device
        data=$(cat < $serial_device)

        # Check if the data matches the expected message format
        if [[ $data == attack\ detected* ]]; then
            # Extract the message text
            message=${data#* }

            # Display the message with the date and time
            echo "$(date) - $message"

            # Run the attack_detected.sh script
            ./attack_detected.sh

        elif [[ $data == attack\ stopped* ]]; then
            # Extract the message text
            message=${data#* }

            # Display the message with the date and time
            echo "$(date) - $message"

            # Run the attack_expired.sh script
            ./attack_expired.sh

        fi
    done
else
    echo "No Arduino device found"
fi

