# Makefile

# Executables
PKM_PACKMOL := packmol
GMX_MDRUN := gmx_d mdrun
TNK_DYNAMIC := dynamic

CONFIGURE := ./configure.pl

MOLNAMES     := kaA kaB
PKM_INPFILE  := packmol.inp
GMX_ITPFILES := $(addsuffix .itp, $(MOLNAMES))
GMX_TOPFILE  := topol.top
GMX_PTLFILES := $(ITPFILES) $(TOPFILE)
GMX_STEPFILE := step.mdp
GMX_CONFIN   := confin.gro
GMX_TARGETS  := $(CONFIN) $(STEP) $(PTLFILES) $(PACKMOLINP)
TNK_KEYFILE  := topol.key
TNK_PRMFILE  := topol.prm
TNK_PTLFILES := $(TNK_KEYFILE) $(TNK_PRMFILE)

# Include macros here
define script =

endef

.PHONY: check clean

%: %.tt
	$(CONFIGURE) $*

$(CONFIN): $(PKM_INPFILE)

clean:
	rm -rf $(PKM_TARGETS)

check:
	@echo "Parameters:"
	@echo "Targets:"
	@echo $(TARGETS)
	@echo 

# vim: tw=65:ts=4:sts=4:sw=4:sta