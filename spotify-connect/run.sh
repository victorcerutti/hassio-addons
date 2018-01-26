#!/bin/bash
#set -e

CONFIG_PATH=/data/options.json

SPOTIFY_NAME="HomeAssistant"
SPOTIFY_USER="$(jq --raw-output '.spotify_user' $CONFIG_PATH)"
SPOTIFY_PASSWORD="$(jq --raw-output '.spotify_password' $CONFIG_PATH)"
SPEAKER="$(jq --raw-output '.speaker' $CONFIG_PATH)"

echo "[Info] Show audio device"
aplay -l

echo "Starting spotify connect"

librespot -n "$SPOTIFY_NAME" -u "$SPOTIFY_USER" -p "$SPOTIFY_PASSWORD" --device "$SPEAKER"
