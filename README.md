# TimeTags Measurement Agent Deployment

This document provides instructions for deploying the timetags_measurement_agent Docker container on a Linux system. The agent interacts with a White Rabbit device and a Time Tagger device for precision measurements.

## Prerequisites

Before deploying the container, ensure the following:
- Docker installed on your system.
- Device Connections:
    - White Rabbit: Connected via a serial-to-USB adapter (e.g., `/dev/ttyUSB0`).
    - Time Tagger: Connected via USB with its serial number known (e.g., `2138000XXX`).
- A running message broker (e.g., activemq) accessible at the specified `BROKER_URL`.

## Deployment Steps

### 1. Clone the Repository
Clone or download the repository containing the run.sh script.
```bash
git clone <repo-url>
cd timetags_measurement_agent
```

### 2. Configure Environment Variables
Update the run.sh script to match your setup:

```bash
BROKER_URL: ActiveMQ broker URL (e.g., amqp://localhost:5672/).
ENDPOINT: The agent's endpoint identifier (e.g., Alice).
WR_TYPE: White Rabbit device type (e.g., LEN).
WR_PORT: Serial port for the White Rabbit device (e.g., /dev/ttyUSB0).
TIME_TAGGER_SERIAL: Serial number of the Time Tagger device.
PPS_CHAN: Pulse-per-second channel.
TRIGGER_LEVEL: Trigger level for the Time Tagger (default: 0.1).
```

### 3. Run the Deployment Script
Make the script executable and run it:

```bash
chmod +x run.sh
./run.sh
```

### Notes
- This setup assumes the environment is Linux-only due to complications with serial port mapping on Windows.
- The `--privileged` flag is used to grant full access to USB devices.
