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

.. vim: tw=55:ts=4:sts=4:sw=4:et:sta
