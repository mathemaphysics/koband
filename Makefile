# Makefile

###############################################
# This is the Makefile that goes with         #
# `configure.pl`, which uses Perl's Template  #
# Toolkit (very similar to Liquid)            #
###############################################

# Executables
PKM_PACKMOL  := packmol
GMX_MDRUN    := gmx_d mdrun
TNK_DYNAMIC  := dynamic
TNK_MINIMIZE := minimize

# The name of the configure file to do the work
CONFIGURE    := ./configure.pl

###############################################
# This block contains all of the parameters   #
# needed to build the initial snapshots; the  #
# prefix denotes the program the variables    #
# pertain to. The prefixes PKM, GMX, and TNK  #
# correspond to Packmol, GROMACS, and Tinker, #
# respectively.                               #
###############################################

MOLNAMES     := kaA kaB
PREFIX       := 01
SUFFIX       := 001
PKM_INPFILE  := packmol.inp
GMX_ITPFILES := $(addsuffix .itp, $(MOLNAMES))
GMX_TOPFILE  := topol.top
GMX_PTLFILES := $(ITPFILES) $(TOPFILE)
GMX_MDPFILE  := step.mdp
GMX_CONFIN   := confin.gro
GMX_TARGETS  := $(GMX_CONFIN) $(GMX_MDPFILE) \
				$(GMX_PTLFILES) $(PKM_INPFILE)
TNK_KEYFILE  := keyfile.key
TNK_PRMFILE  := prmfile.prm
TNK_PTLFILES := $(TNK_KEYFILE) $(TNK_PRMFILE)
TNK_TARGETS  := $(TNK_PTLFILES) $(PKM_INPFILE)

# Include macros here
define script =

endef

.PHONY: check clean

%: %.tt
	$(CONFIGURE) $<

$(GMX_CONFIN): $(PKM_INPFILE)

clean:
	rm -rf $(PKM_TARGETS)

check:
	@echo "Parameters:"
	@echo "Gromacs Targets:"
	@echo $(GMX_TARGETS)
	@echo "Tinker Targes:"
	@echo $(TNK_TARGETS)

# vim: tw=65:ts=4:sts=4:sw=4:sta
