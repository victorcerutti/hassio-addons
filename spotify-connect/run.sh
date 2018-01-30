#!/bin/bash
set -e

echo "[Info] Show audio device"
aplay -l

CONFIG_PATH=/data/options.json

length=$(jq --raw-output '.instances | length' $CONFIG_PATH)

for i in `seq 0 $(($length-1))`; do

  DISCOVERY_MODE="$(jq --raw-output ".instances[$i] .discovery_mode" $CONFIG_PATH)"

  SPEAKER="$(jq --raw-output ".instances[$i] .speaker" $CONFIG_PATH)"
  if [ "$SPEAKER" == "null" ] ; then
    SPEAKER="hw:0,1"
  fi

  DEVICE_TYPE="$(jq --raw-output ".instances[$i] .device_type" $CONFIG_PATH)"
  if [ "$DEVICE_TYPE" == "null" ] ; then
    DEVICE_TYPE="speaker"
  fi

  DEVICE_NAME="$(jq --raw-output ".instances[$i] .device_name" $CONFIG_PATH)"

  BITRATE="$(jq --raw-output ".instances[$i] .bitrare" $CONFIG_PATH)"
  if [ "$BITRATE" == "null" ] ; then
    BITRATE="160"
  fi

  ALLOW_GUESTS=""
  if [ "$(jq --raw-output ".instances[$i] .allow_guests" $CONFIG_PATH)" == "false" ] ; then
    ALLOW_GUESTS="--disable-discovery"
  fi

  INITIAL_VOLUME="$(jq --raw-output ".instances[$i] .initial_volume" $CONFIG_PATH)"
  if [ "$INITIAL_VOLUME" == "null" ] ; then
    INITIAL_VOLUME=80
  fi

  SPOTIFY_USER="$(jq --raw-output ".instances[$i] .spotify_user" $CONFIG_PATH)"
  SPOTIFY_PASSWORD="$(jq --raw-output ".instances[$i] .spotify_password" $CONFIG_PATH)"


  if [ "$SPOTIFY_USER" == "null" ] || [ "$SPOTIFY_PASSWORD" == "null" ] ; then
    echo "[$(($i+1))/$length] Starting spotify connect without account"
    if [ $i == $(($length-1)) ] ; then
      librespot -n "$DEVICE_NAME" --device "$SPEAKER" --bitrate "$BITRATE" --initial-volume	"$INITIAL_VOLUME" --device-type	"$DEVICE_TYPE" "$ALLOW_GUESTS"
    else
      librespot -n "$DEVICE_NAME" --device "$SPEAKER" --bitrate "$BITRATE" --initial-volume	"$INITIAL_VOLUME" --device-type	"$DEVICE_TYPE" "$ALLOW_GUESTS" &
    fi

  else
    echo "[$(($i+1))/$length] Starting spotify with account $SPOTIFY_USER"
    if [ $i == $(($length-1)) ] ; then
      librespot -n "$DEVICE_NAME" -u "$SPOTIFY_USER" -p "$SPOTIFY_PASSWORD" --device "$SPEAKER" --bitrate "$BITRATE" --initial-volume	"$INITIAL_VOLUME" --device-type	"$DEVICE_TYPE"  "$ALLOW_GUESTS"
    else
      librespot -n "$DEVICE_NAME" -u "$SPOTIFY_USER" -p "$SPOTIFY_PASSWORD" --device "$SPEAKER" --bitrate "$BITRATE" --initial-volume	"$INITIAL_VOLUME" --device-type	"$DEVICE_TYPE"  "$ALLOW_GUESTS" &
    fi
  fi

  #just wait a couple seconds for better log understanding
  sleep 2

done
