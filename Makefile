# Makefile

MOLECULES := c8 tf2
PACKMOLPRM := packmol.inp
POTENTIAL := $(addsuffix .itp, $(MOLECULES)) topol.top
MDPFILE := step.mdp
CONFIN := confin.gro
TARGETS := $(CONFIN) $(MDPFILE) $(POTENTIAL) $(POTENTIAL) $(PACKMOLPRM)

# Include macros here
define script =

endef

.PHONY: check

%: %.tt
	./configure.pl $*

$(CONFIN): $(PACKMOLPRM)


check:
	@echo "Parameters:"
	@echo "Targets:"
	@echo $(TARGETS)
	@echo 

# vim: tw=65:ts=4:sts=4:sw=4:sta
