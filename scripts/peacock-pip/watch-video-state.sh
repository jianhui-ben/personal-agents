#!/bin/bash
# Watch Peacock video element state — run during a commercial to capture ad signals
echo "Watching video state... (Ctrl+C to stop)"
JS='var vs = document.querySelectorAll("video"); vs.length + " videos | " + Array.from(vs).map(function(v,i){ return "v"+i+"(id="+v.id+",paused="+v.paused+",muted="+v.muted+",w="+v.videoWidth+")"; }).join(", ")'
while true; do
  result=$(osascript -e "tell application \"Google Chrome\" to execute front window's active tab javascript \"$JS\"")
  echo "$(date +%H:%M:%S) $result"
  sleep 2
done
