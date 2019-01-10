# A test Makefile for extending guile and make
# in various ways: Using guile itself in Makefile,
# building a C module to extend guile (only when
# used directly in guile), and finally compiling
# an actual extended gnumake module compatible with
# GPL and <gnumake.h>.

.PHONY: all clean tempfile

all: tempfile testfile01.txt guileext01-module.so guileext02-gnumake.so

########################################
# Build guile extension just for guile #
########################################

guileext01-module.so: guileext01-module.c
	gcc `pkg-config --cflags guile-2.2` -shared -o guileext01-module.so -fPIC guileext01-module.c

#############################################
# Extending GNU make with guile script only #
#############################################

define GUILEIO =
;; A simple Guile IO library for GNU make

(define MKPORT #f)

(define (mkopen name mode)
    (set! MKPORT (open-file name mode))
      #f)

(define (mkwrite s)
    (display s MKPORT)
      (newline MKPORT)
        #f)

(define (mkclose)
    (close-port MKPORT)
      #f)

#f
endef

# Internalize the Guile IO functions
$(guile $(GUILEIO))

testfile01.txt:
	@echo "TARGET: $@"
	@echo "Added functions for writing to files"
	$(guile (mkopen "testfile01.txt" "w")) \
	$(guile (mkwrite "This is some stuff")) \
	$(guile (mkclose))

#######################################
# Compiling actual GNU make extension #
#######################################

-load guileext02-gnumake.so

tempfile: guileext02-gnumake.so
	@echo "Making temporary file: $(mk-temp tmpfile.)"

guileext02-gnumake.so: guileext02-gnumake.c
	$(CC) -shared -fPIC -o $@ $<

.PHONY: check

check:
	$(hello "poopdapants2")

clean:
	rm -f tmpfile.*
	rm -f testfile01.txt
	rm -f guileext01-module.so
	rm -f guileext02-gnumake.so

# vim: tabstop=4:softtabstop=4:shiftwidth=4:smarttab:syntax=make
