"""png_info.py <file> <width> <height> [noalpha]: exit non-zero if the PNG does not match."""
import struct
import sys

path, w, h = sys.argv[1], int(sys.argv[2]), int(sys.argv[3])
with open(path, 'rb') as f:
    assert f.read(8) == b'\x89PNG\r\n\x1a\n', 'not a PNG'
    f.read(8)
    width, height, _depth, color = struct.unpack('>IIBB', f.read(10))
assert (width, height) == (w, h), f'{width}x{height}'
if 'noalpha' in sys.argv[4:]:
    assert color in (0, 2, 3), f'color type {color} has alpha'
