
#
# Include the compiler stuff
#
include ../../../makefiles/compile.mk

#
# Define the full name of the real target
#
REALTARGET=$(TARGETDIR)/lib$(TARGET)

#
# The top level make target, makes the directory an library
#
all: startmsg mkdirs $(REALTARGET) endmsg

include ../../../makefiles/test.mk

startmsg:
	@echo
	@echo Building library $(notdir $(REALTARGET))
	@echo $(LINE)

endmsg:
	@echo $(LINE)
	@echo
	@echo


#
# The clean target
#
clean::
	rm -f $(REALTARGET) $(OBJS)

#
# Make the library
#
ifeq ($(VERBOSE),1)
$(REALTARGET): $(OBJS)
	$(AR) r $@ $(OBJS)
else
$(REALTARGET): $(OBJS)
	@echo -n "Creating library '"$(notdir $(REALTARGET))"' ... "
	@$(AR) r $@ $(OBJS) > /dev/null 2>&1
	@echo done
endif

#
# Create the directories needed
#
mkdirs::
	-mkdir -p $(TARGETDIR)
	-mkdir -p $(OBJDIR)
	-mkdir -p $(DEPDIR)
ifneq "$(TARGETMKDIRS)" ""
	-mkdir -p $(TARGETMKDIRS)
endif

$(DEPDIR)/%.d: ;

.PRECIOUS: $(DEPDIR)/%.d

-include $(addsuffix .Td,$(addprefix $(DEPDIR),$(basename $(SRC))))
