TARGET		= i2ctest
CPU_TYPE	= 6502
FIRMWARE_CFG	= mibu65.cfg

CA65_BINARY	= ca65
CA65_FLAGS	= --cpu $(CPU_TYPE) -I $(COMMON_INCLUDE)

LD65_BINARY	= ld65
LD65_FLAGS	= -C $(FIRMWARE_CFG)

MKDIR_BINARY	= mkdir
MKDIR_FLAGS	= -p

BUILD_ROOT	= ./build

COMMON_ROOT	= ./common
COMMON_SOURCE	= $(COMMON_ROOT)/source
COMMON_INCLUDE	= $(COMMON_ROOT)/include
COMMON_BUILD	= $(BUILD_ROOT)/common

ROM_ROOT	= ./rom
ROM_BUILD	= $(BUILD_ROOT)/rom

BIN_BUILD	= $(BUILD_ROOT)/bin

all:	$(BIN_BUILD)/$(TARGET).bin 

clear:
	rm -r build

include	$(COMMON_ROOT)/makefile
include	$(ROM_ROOT)/makefile
