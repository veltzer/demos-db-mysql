##############
# parameters #
##############
# do you want to check bash syntax?
DO_CHECK_SYNTAX:=1

########
# code #
########
ALL:=
ALL_SH:=$(shell find . -name "*.sh" -printf "%P\n" 2> /dev/null)
ALL_SH_STAMP:=$(addprefix out/, $(addsuffix .stamp, $(ALL_SH)))

# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

ifeq ($(DO_CHECK_SYNTAX),1)
ALL+=$(ALL_SH_STAMP)
endif # DO_CHECK_SYNTAX

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	@true

.PHONY: debug
debug:
	$(info ALL is $(ALL))
	$(info ALL_SH is $(ALL_SH))
	$(info ALL_SH_STAMP is $(ALL_SH_STAMP))

############
# patterns #
############
$(ALL_SH_STAMP): out/%.stamp: % .shellcheckrc
	$(info doing [$@])
	$(Q)shellcheck --shell=bash $<
	$(Q)pymakehelper touch_mkdir $@
