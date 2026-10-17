#!/usr/bin/env python3
# Minimal ff2mpv native messaging host: read {"url":..., "options":[...]} and launch mpv detached.
import json, struct, subprocess, sys

n = struct.unpack("@I", sys.stdin.buffer.read(4))[0]
msg = json.loads(sys.stdin.buffer.read(n))
subprocess.Popen(
    ["/usr/bin/mpv", "--no-terminal",
     *msg.get("options", []), "--", msg["url"]],
    stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
    start_new_session=True,
)
out = b"null"
sys.stdout.buffer.write(struct.pack("@I", len(out)) + out)
sys.stdout.buffer.flush()
