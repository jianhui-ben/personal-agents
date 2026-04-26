#!/usr/bin/env python3
import subprocess, time, datetime

JS = """
var vs = document.querySelectorAll('video');
var out = vs.length + ' videos | ';
out += Array.from(vs).map(function(v, i) {
  return 'v' + i + '(id=' + v.id + ',paused=' + v.paused + ',muted=' + v.muted + ',w=' + v.videoWidth + ')';
}).join(', ');
out
"""

print("Watching video state... (Ctrl+C to stop)")
while True:
    result = subprocess.run(
        ['osascript', '-e', f"tell application \"Google Chrome\" to execute front window's active tab javascript {repr(JS)}"],
        capture_output=True, text=True
    )
    ts = datetime.datetime.now().strftime('%H:%M:%S')
    output = result.stdout.strip() or result.stderr.strip()
    print(f"{ts} {output}")
    time.sleep(2)
