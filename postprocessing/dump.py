# coding: utf-8
import os
import pathlib as pl
import numpy as np

plist = pl.Path('.').glob('???')

total = np.zeros((5001, 6400), dtype=np.float)

n = 0
for p in plist:
    ps = pl.Path(str(p) + '.npy')
    if not ps.exists():
        print('Opening %s' % str(p))
        data = np.loadtxt(fname=str(pl.Path(p, 'msd-all.xvg')), comments=['#', '@'])
        np.save(str(p), data)
    else:
        print('Opening %s' % str(ps))
        data = np.load(str(ps))
    total = total + np.array(data[:, 1:])
    n = n + 1
total = total / n
np.save('total', total)    
