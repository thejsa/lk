LOCAL_DIR := $(GET_LOCAL_DIR)

INCLUDES += -I$(LOCAL_DIR)/include -I$(LK_TOP_DIR)/platform/msm_shared
INCLUDES += -I$(LK_TOP_DIR)/dev/gcdb/display -I$(LK_TOP_DIR)/dev/gcdb/display/include

PLATFORM := msm8226

MEMBASE := 0x0FF00000 # SDRAM (Make UEFI comfortable)
MEMSIZE := 0x00100000 # 1MB

BASE_ADDR        := 0x00000

# You shall modify these values to make UEFI stack comfortable
TAGS_ADDR        := BASE_ADDR+0x00000100
KERNEL_ADDR      := BASE_ADDR+0x00008000
RAMDISK_ADDR     := BASE_ADDR+0x01000000
SCRATCH_ADDR     := 0x10000000
SCRATCH_SIZE     := 0x20000000

# UEFI FrameBuffer
UEFI_FB_BASE := 0x00400000
UEFI_FB_SIZE := 0x00800000
UEFI_FB_HORZ := 720
UEFI_FB_VERT := 1280

DEFINES += DISPLAY_SPLASH_SCREEN=1
DEFINES += DISPLAY_TYPE_MIPI=1
DEFINES += DISPLAY_TYPE_DSI6G=1
DEFINES += CHAINLOADED_UEFI=1

# Not really necessary. Get your console cable ready!
DEFINES += WITH_DEBUG_FBCON=1

MODULES += \
	dev/keys \
	lib/ptable \
	dev/pmic/pm8x41 \
	dev/gcdb/display \
	dev/vib \
	lib/libfdt

DEFINES += \
	MEMSIZE=$(MEMSIZE) \
	MEMBASE=$(MEMBASE) \
	BASE_ADDR=$(BASE_ADDR) \
	TAGS_ADDR=$(TAGS_ADDR) \
	KERNEL_ADDR=$(KERNEL_ADDR) \
	RAMDISK_ADDR=$(RAMDISK_ADDR) \
	SCRATCH_ADDR=$(SCRATCH_ADDR) \
	SCRATCH_SIZE=$(SCRATCH_SIZE) \
	UEFI_FB_BASE=$(UEFI_FB_BASE) \
	UEFI_FB_SIZE=$(UEFI_FB_SIZE) \
	UEFI_FB_VERT=$(UEFI_FB_VERT) \
	UEFI_FB_HORZ=$(UEFI_FB_HORZ)

OBJS += \
    $(LOCAL_DIR)/init.o \
    $(LOCAL_DIR)/meminfo.o \
    $(LOCAL_DIR)/target_display.o \
    $(LOCAL_DIR)/oem_panel.o

CFLAGS += -Wno-missing-field-initializers -Wno-unused-variable