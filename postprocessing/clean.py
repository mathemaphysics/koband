#!/usr/bin/python3

from pathlib import Path

plist = Path('.').glob('???')

for p in plist:
    ps = Path(p, 'traj.trr')
    if ps.exists():
        print('Removing %s' % str(ps))
        ps.unlink()
    else:
        print('No trajectory at %s' % str(ps))

