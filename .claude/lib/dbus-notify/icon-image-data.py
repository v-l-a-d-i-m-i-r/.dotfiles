"""Print the PNG icon as a GVariant `image-data` value for D-Bus notifications.

The icon travels inside the message, so it works when the notification
daemon runs on another host (forwarded D-Bus socket).
Supports 8-bit RGBA, non-interlaced PNG only.
"""
import struct
import sys
import zlib

data = open(sys.argv[1], "rb").read()
pos = 8
idat = b""
while pos < len(data):
    length, kind = struct.unpack(">I4s", data[pos:pos + 8])
    body = data[pos + 8:pos + 8 + length]
    if kind == b"IHDR":
        width, height = struct.unpack(">II", body[:8])
    elif kind == b"IDAT":
        idat += body
    pos += 12 + length

raw = zlib.decompress(idat)
stride = width * 4
rows = []
prev = bytearray(stride)
for y in range(height):
    start = y * (stride + 1)
    ftype = raw[start]
    row = bytearray(raw[start + 1:start + 1 + stride])
    for i in range(stride):
        a = row[i - 4] if i >= 4 else 0
        b = prev[i]
        c = prev[i - 4] if i >= 4 else 0
        if ftype == 1:
            add = a
        elif ftype == 2:
            add = b
        elif ftype == 3:
            add = (a + b) // 2
        elif ftype == 4:
            p = a + b - c
            pa, pb, pc = abs(p - a), abs(p - b), abs(p - c)
            add = a if pa <= pb and pa <= pc else b if pb <= pc else c
        else:
            add = 0
        row[i] = (row[i] + add) & 0xFF
    rows.append(row)
    prev = row

pixels = ",".join(str(v) for row in rows for v in row)
print(f"<({width},{height},{stride},true,8,4,[byte {pixels}])>")
