TARGET_ROOT	= $(ROM_ROOT)/$(TARGET)

include $(TARGET_ROOT)/makefile

TARGET_OBJECTS	= $(SOURCES:%.s=$(ROM_BUILD)/%.o)
TARGET_COMMONS	= $(COMMONS:%=$(COMMON_BUILD)/%.o)

$(ROM_BUILD)/%.o: $(TARGET_ROOT)/%.s
	@$(MKDIR_BINARY) $(MKDIR_FLAGS) $(ROM_BUILD)
	$(CA65_BINARY) $(CA65_FLAGS) -o $@ $^

$(BIN_BUILD)/%.bin: $(TARGET_OBJECTS) $(TARGET_COMMONS) $(FIRMWARE_CFG)
	@$(MKDIR_BINARY) $(MKDIR_FLAGS) $(BIN_BUILD)
	$(LD65_BINARY) $(LD65_FLAGS) -o $@ $(TARGET_OBJECTS) $(TARGET_COMMONS)
