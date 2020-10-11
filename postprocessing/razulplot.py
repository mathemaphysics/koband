#!/usr/bin/python

import pymol
import re
import math
import numpy as np
from argparse import ArgumentParser

parser = ArgumentParser(
            description='Generate text files for input to razulplot.py'
        )
parser.add_argument(
            'time',
            type=float,
            default=10.0,
            help='The time in picoseconds'
        )
args = parser.parse_args()

rmin=0.034; # Originally 0.034
rmax=1.9; # Originally 1.7

ffn = "confout.gro"

fvals = list(enumerate(np.loadtxt('total-%05.2fps.txt' % args.time)))
fvals.sort(key=lambda m: m[1])
indexl = np.array(fvals)[:, 0].astype(np.int)
for i in range(len(indexl)):
    indexl[i] = indexl[i] + 1
indexs = np.flip(indexl, 0)

nl = len(indexl);
print("nl = %d" % nl);

ns = len(indexs);
print("ns = %d" % ns);

radiusl=[];
for j in range(1,nl+1):
    radiusl.append( rmin * math.exp( float(j-nl) / float(1-nl) * math.log(rmax/rmin) ) );

radiuss=[];
for j in range(1,ns+1):
    radiuss.append( rmin * math.exp( float(j-ns) / float(1-ns) * math.log(rmax/rmin) ) );

#print('%r' % radiusl)
print("Min indexl = %d" % min(indexl))
print("Max indexl = %d" % max(indexl))

# Do the plotting with PyMol
pymol.finish_launching();
pymol.cmd.load(filename=ffn,object="system1");
pymol.cmd.load(filename=ffn,object="system2");
pymol.cmd.hide("everything");
for j in range(0,nl):
    pymol.cmd.alter( "system1 & index %d" % indexl[j], "vdw=%15.7f" % radiusl[j] );
    pymol.cmd.alter( "system1 & index %d" % indexl[j], "color=3" );
    pymol.cmd.show( "spheres", "system1 & index %d" % indexl[j] );
    print("Set size of index %8d -> %8d -> %15.7f" % (j,indexl[j],radiusl[j]));
for j in range(0,ns):
    pymol.cmd.alter( "system2 & index %d" % indexs[j], "vdw=%15.7f" % radiuss[j] );
    pymol.cmd.alter( "system2 & index %d" % indexs[j], "color=4" );
    pymol.cmd.show( "spheres", "system2 & index %d" % indexs[j] );
    print("Set size of index %8d -> %8d -> %15.7f" % (j,indexs[j],radiuss[j]));

#pymol.cmd.color("red","alltails");
#pymol.cmd.color("blue","nottails");
#pymol.cmd.show( "lines", "atoms" );

pymol.cmd.rebuild();
#ofn = re.sub('out.sorted.largest','png',dfn);
#pfn = re.sub('out.sorted.largest','pse',dfn);
#print "Saving rendering to %s" % ofn;
#print "Saving session to %s" % pfn;
#pymol.cmd.png(ofn);
#pymol.cmd.save(pfn);
#pymol.cmd.quit();

# vim: tabstop=4:softtabstop=4:shiftwidth=4:expandtab:smarttab
