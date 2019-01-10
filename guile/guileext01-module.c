#include <math.h>
#include <libguile.h>
//#include <gnumake.h>

SCM
j0_wrapper (SCM x)
{
	  return scm_from_double (j0 (scm_to_double (x)));
}

SCM
id_wrapper (SCM x)
{
    return scm_from_double (scm_to_double (x));
}

void
init_bessel ()
{
    scm_c_define_gsubr ("j0", 1, 0, 0, j0_wrapper);
}

void
init_ident ()
{
    scm_c_define_gsubr ("id", 1, 0, 0, id_wrapper);
}

// vim: tabstop=4:softtabstop=4:shiftwidth=4:expandtab:smarttab
