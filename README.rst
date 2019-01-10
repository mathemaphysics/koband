==================================
Parameters for Kob-Andersen System
==================================

The following are the input parameters used for this
simulation of the Kob-Andersen liquid.

.. code-block:: python

   N_A = 4000
   N_B = 1000
   T_r = 0.55

Variables :math:`N_A` and :math:`N_B` are the numbers of
**Type A** and **Type B** atoms of the Kob-Andersen
model, and :math:`T_r` is the target temperature
specified in *reduced* units (to be described below.

Reduced Units
=============

In situations like this one, it turns out that not all
parameters used to specify the state of the system are
independent. For example, :math:`\sigma_A`,
:math:`\sigma_B`, and :math:`\Delta x` are related to
one another as a result of the fact that each of these
depends on available space.


.. vim: tw=55:ts=4:sts=4:sw=4:et:sta
