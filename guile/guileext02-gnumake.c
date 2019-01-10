#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <gnumake.h>

int plugin_is_GPL_compatible;

char *
hello (const char *nm, unsigned int argc, char **argv)
{
  int len = strlen (argv[0]) + 7;
  char *buf = gmk_alloc (len);
  sprintf (buf, "echo Hello %s", argv[0]);
  printf("hello!\n");
  return buf;
}

int
guileext02_gmk_setup ()
{
  gmk_add_function ("hello", hello, 1, 1, 1);
  return 1;
}
