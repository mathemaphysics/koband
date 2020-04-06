==============================
Generate a Kob-Andersen System
==============================

Introduction
============

This is a set of scripts and compiled code for
generating a input files for a Kob-Andersen system
in three dimensions in a number of different molecular
dynamics codes. The primary MD codes are GROMACS and
Tinker.

The Kob-Andersen liquid is a simple atomic liquid which
is commonly used in the field of condensed matter physics
for studying glassy liquid behavior. It is a liquid
which displays a structural glass transition around T = 0.45
(in reduced temperature units).

There are two atom types within the model, type A and type B.
In the 80:20 KA liquid, there are 4 times as many A as B.
Type A is larger in Vanderwaals radius than B. However, the
A-B pair Vanderwaals energy of interaction, :math:`\epsilon_{AB}`,
is greater than that of either A-A or B-B. It is partially for
this reason that the system is glassy.

Details
=======

The following are the input parameters used for
this simulation of the Kob-Andersen liquid.

.. code-block:: python

   N_A = 4000
   N_B = 1000
   T_r = 0.55

Variables :math:`N_A` and :math:`N_B` are the
numbers of **Type A** and **Type B** atoms of the
Kob-Andersen model, and :math:`T_r` is the target
temperature specified in *reduced* units (to be
described below.

Reduced Units
=============

In situations like this one, it turns out that not
all parameters used to specify the state of the
system are independent. For example,
:math:`\sigma_A`, :math:`\sigma_B`, and
:math:`\Delta x` are related to one another as a
result of the fact that each of these depends on
available space.

Notes on Files
==============

The file names are intended to serve as a guide
for what they do, I hope. The MDP files are for
different purposes each. The file `step-min.mdp`
is generated for minimization. So use it to do
a minimization after the initial `packmol` system
is generated. It is important to note that you
**still need to do this minimization with the
target software since packmol doesn't use the
same potential**. You can end up blowing up your
simulation if you dive right in with the file
straight from `packmol`, i.e. `confin-box.gro`.
The MDP file `step-pre.mdp` will set up a run
for a small fraction of the total time of the
full simulation in the constant energy ensemble
in order to smooth things out before runnin at
the target temperature. Finally, there's the
full run MDP file `step-run.mdp`, which will
set generate random velocities initially, as
needed by the isoconfigurational (IC) ensemble,
and will proceed to run for the allotted time
using the velocity rescaling method for running
canonical ensemble simulation.

At this point there are also two different files
to feed to `packmol`. The originally named file,
`packmol.inp` will center the system's origin
at the positional coordinates (0, 0, 0) nm. In
addition, there's a file named `packmol-pos.inp`
which places the bottom lower lefthand corner
of the system cube at (0, 0, 0) nm instead. You
can choose which of these is used by editing the
`Makefile` to set `PKG_INPFILE`. The default at
this point is `packmol-pos.inp`, since it is
what is expected in general by GROMACS. However
the downside of this is that TINKER is generally
unhappy with this setup. So I recommend using the
original `packmol.inp` file for simulations for
which you want to use TINKER.

.. vim: tw=55:ts=4:sts=4:sw=4:et:sta
