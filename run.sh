#!/bin/bash

# ========== CONFIGURABLE PARAMETERS ==========
# Container and image configuration
CONTAINER_NAME="timetags_measurement_agent_container"
IMAGE_NAME="amlabdr/timetags_measurement_agent:latest"

# Environment variables for the application
BROKER_URL="amqp://localhost:5672/"
ENDPOINT="Alice"
WR_TYPE="LEN"
WR_PORT="/dev/ttyUSB0"               # Serial port for White Rabbit
TIME_TAGGER_SERIAL="2138000XHS"      # Serial number for the Time Tagger
PPS_CHAN="1"
TRIGGER_LEVEL="0.1"

# Stop and remove any running container with the same name
echo "Stopping and removing existing container (if any)..."
docker stop "$CONTAINER_NAME" >/dev/null 2>&1 || true
docker rm "$CONTAINER_NAME" >/dev/null 2>&1 || true

# Attempt to pull the latest image
echo "Attempting to pull the latest image..."
if docker pull "$IMAGE_NAME"; then
    echo "Successfully pulled the latest image."
else
    echo "Warning: Failed to pull the image. Using the existing local image, if available."
fi

# Prepare the run command
echo "Starting the container..."
DOCKER_CMD="docker run --name \"$CONTAINER_NAME\""

# Add environment variables
DOCKER_CMD+=" -e BROKER_URL=\"$BROKER_URL\""
DOCKER_CMD+=" -e ENDPOINT=\"$ENDPOINT\""
DOCKER_CMD+=" -e WR_TYPE=\"$WR_TYPE\""
DOCKER_CMD+=" -e WR_PORT=\"$WR_PORT\""
DOCKER_CMD+=" -e TIME_TAGGER_SERIAL=\"$TIME_TAGGER_SERIAL\""
DOCKER_CMD+=" -e PPS_CHAN=\"$PPS_CHAN\""
DOCKER_CMD+=" -e TRIGGER_LEVEL=\"$TRIGGER_LEVEL\""
DOCKER_CMD+=" --privileged"

# Add the image name
DOCKER_CMD+=" \"$IMAGE_NAME\""

# Execute the run command
if ! eval $DOCKER_CMD; then
    echo "Error: Failed to start the container."
    exit 1
fi
