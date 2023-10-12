#!/bin/env sh

active_profile=$(pacmd list-sinks | grep 'active port' | awk '{ print $3 }' | tr -d '><');

if [ "$BLOCK_BUTTON" == 1 ] && [ "$active_profile" == "analog-output-headphones" ]; then
  pacmd set-sink-port $(pacmd list-sinks | sed -n -e '3{p;q}' | awk '{ print $2 }' | tr -d '><') analog-output-speaker;

  echo '🔊';
  exit 0;
fi

if [ "$BLOCK_BUTTON" == 1 ] && [ "$active_profile" == "analog-output-speaker" ]; then
  pacmd set-sink-port $(pacmd list-sinks | sed -n -e '3{p;q}' | awk '{ print $2 }' | tr -d '><') analog-output-headphones;

  echo '🎧';
  exit 0;
fi

if [ "$active_profile" == "analog-output-headphones" ]; then
  echo '🎧';
fi

if [ "$active_profile" == "analog-output-speaker" ]; then
  echo '🔊';
fi
