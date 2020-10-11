#!/usr/bin/python3

from pathlib import Path

plist = Path('.').glob('???')

for p in plist:
    ps = Path(p, 'msd-all.xvg')
    if ps.exists():
        print('Removing %s' % str(ps))
        ps.unlink()
    else:
        print('No data file at %s' % str(ps))

