#
# Makefile for the touchscreen drivers.
#

obj-$(CONFIG_TOUCHSCREEN_ST_FTS_V521)		+= fts.o fts_proc.o fts_lib/

# Ignore this warn
ifeq ($(cc-name),clang)
EXTRA_CFLAGS += $(call cc-disable-warning,typedef-redefinition,)
endif
