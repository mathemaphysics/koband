#!/usr/bin/python3

from pathlib import Path
from numpy import load
from sys import argv, exit
from re import search
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
parser.add_argument(
            '--quiet',
            action='store_true',
            help='Run quietly and don\'t ask questions'
        )
args = parser.parse_args()

# This should be configured, 5000 => [% GET numtimes %]
maxidx = 5000 - 1

tps = args.time
tst = int(tps / 0.02)
if tst < 0 or tst > maxidx:
    exit('Time outside of bounds.')

p = Path('total-%05.2fps.txt' % tps)
if not args.quiet:
    if p.exists():
        okay = input('Warning: File %s already exists! Continue? (y/n): ' % str(p))
        if search('[nN]', okay) != None:
            exit('Exiting. No files changed.')
        else:
            print('Continuing.')

f = load('total.npy')
fp = p.open('w')
for v in f[tst, :]:
    fp.write(str(v) + '\n')
fp.close()
