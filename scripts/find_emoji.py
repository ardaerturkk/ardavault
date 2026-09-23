"""Exit 0 (found) if any file under the given paths contains an emoji, else 1."""
import os
import re
import sys

EMOJI = re.compile(
    '[\U0001F000-\U0001FAFF\U00002600-\U000027BF\U0001F1E6-\U0001F1FF'
    '\U00002B00-\U00002BFF\U0000FE0F\U0000200D]'
)
found = False
for root in sys.argv[1:]:
    paths = [root] if os.path.isfile(root) else [
        os.path.join(d, f) for d, _, fs in os.walk(root) for f in fs]
    for p in paths:
        if not p.endswith(('.dart', '.arb', '.md', '.txt', '.json', '.yaml')):
            continue
        with open(p, encoding='utf-8', errors='ignore') as fh:
            for n, line in enumerate(fh, 1):
                if EMOJI.search(line):
                    print(f'{p}:{n}: {line.strip()}')
                    found = True
sys.exit(0 if found else 1)
