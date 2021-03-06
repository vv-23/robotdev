#
# validate the build environment
#
# This sensure the CONFIG variable is something legal.  It is not checked
# in other places for validity and this name will be used as a directory for
# the build.
#

ifndef CONFIG
$(error missing the CONFIG variable on the make command line, e.g. make CONFIG=debug)
else
ifeq ($(CONFIG), debug)
else
ifeq ($(CONFIG), release)
else
$(error CONFIG must be set to either 'debug' or 'release')
endif
endif
endif
