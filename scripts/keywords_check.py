"""keywords_check.py <store/locale dir>: fail if a keyword repeats a word from name or subtitle."""
import re
import sys

d = sys.argv[1]
words = lambda s: {w for w in re.split(r'[\s,:\-]+', s.lower()) if w}
taken = words(open(f'{d}/name.txt').read()) | words(open(f'{d}/subtitle.txt').read())
keys = [k.strip().lower() for k in open(f'{d}/keywords.txt').read().split(',')]
dup = [k for k in keys if k in taken]
if dup:
    print('keywords repeat name/subtitle words:', dup)
    sys.exit(1)
