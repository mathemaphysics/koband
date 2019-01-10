#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <gnumake.h>

int plugin_is_GPL_compatible;

char *hello (const char *nm, unsigned int argc, char **argv)
{
	int len = strlen (argv[0]);
	char *buf = gmk_alloc (len+16);
	sprintf (buf, "Hello, %s", argv[0]);
	printf("Running stuff: %s\n", buf);
	return NULL;
}

int guileext02_gmk_setup ()
{
	gmk_add_function ("hello", hello, 1, 1, 1);
	return 1;
}

// vim: tw=65:ts=4:sts=4:sw=4:et:sta
