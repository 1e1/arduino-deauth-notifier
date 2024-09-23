# Register a service for listening the ESP8266

It's better to notify the Deauth attack by USB rather than the WiFi ;) 

Script to add on `/etc/systemd/system/arduino-monitor.service`
```
[Unit]
Description=Arduino Monitor Service
After=network.target

[Service]
# EDIT
ExecStart=/path/to/monitor_arduino_serial.sh
Restart=always
User=root
Group=root
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=arduino-monitor

[Install]
WantedBy=multi-user.target
```

- Reload the systemd configuration to load the new service file:
```sudo systemctl daemon-reload```

- Enable the service to start automatically at boot:
```sudo systemctl enable arduino-monitor```

- Start the service:
```sudo systemctl start arduino-monitor```

- You can check the status of the service with:
```sudo systemctl status arduino-monitor```

And you can stop, restart, or reload the service as needed with systemctl stop, systemctl restart, and systemctl reload commands, respectively.


