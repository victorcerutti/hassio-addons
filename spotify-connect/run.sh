#!/bin/bash
set -e

echo "[Info] Show audio device"
aplay -l

CONFIG_PATH=/data/options.json

length=$(jq --raw-output '.instances | length' $CONFIG_PATH)

echo $i_length instances found

output='2>&1 &'

for i in `seq 0 $(($length-1))`; do

  DISCOVERY_MODE="$(jq --raw-output ".instances[$i] .discovery_mode" $CONFIG_PATH)"
  SPEAKER="$(jq --raw-output ".instances[$i] .speaker" $CONFIG_PATH)"
  if [ "$SPEAKER" == "null" ] ; then
    SPEAKER="hw:0,1"
  fi
  DEVICE_NAME="$(jq --raw-output ".instances[$i] .device_name" $CONFIG_PATH)"

  if [ "$DISCOVERY_MODE" = true ] ; then
    echo "[$(($i+1))/$length] Starting spotify connect in discovery mode"
    if [ $i == $(($length-1)) ] ; then
      librespot -n "$DEVICE_NAME" --device "$SPEAKER" $output
    else
      librespot -n "$DEVICE_NAME" --device "$SPEAKER" $output 2>&1 &
    fi

  else
    SPOTIFY_USER="$(jq --raw-output ".instances[$i] .spotify_user" $CONFIG_PATH)"
    SPOTIFY_PASSWORD="$(jq --raw-output ".instances[$i] .spotify_password" $CONFIG_PATH)"
    echo "[$(($i+1))/$length] Starting spotify with account $SPOTIFY_NAME"
    if [ $i == $(($length-1)) ] ; then
      librespot -n "$DEVICE_NAME" -u "$SPOTIFY_USER" -p "$SPOTIFY_PASSWORD" --device "$SPEAKER"
    else
      librespot -n "$DEVICE_NAME" -u "$SPOTIFY_USER" -p "$SPOTIFY_PASSWORD" --device "$SPEAKER" 2>&1 &
    fi
  fi

done
