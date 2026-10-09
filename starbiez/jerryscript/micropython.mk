JERRY_DIR := $(USERMOD_DIR)/jerryscript
JERRY_CORE := $(JERRY_DIR)/jerry-core

CFLAGS += \
	-Wno-error=cast-align \
	-Wno-error=float-equal \
	-Wno-error=implicit-fallthrough \
	-Wno-error=attributes \
	-Wno-error=double-promotion \
	-Wno-error=discarded-qualifiers \
	-Wno-error=overflow
CFLAGS_USERMOD += \
    -DJERRY_LINE_INFO=0 \
    -Wno-cast-align \
    -Wno-error=cast-align \
    -Wno-float-equal \
    -Wno-error=float-equal \
    -Wno-implicit-fallthrough \
    -Wno-undef \
    -Wno-nested-externs

# F*CK YOU JERRYSCRIPT!!

INC += -I$(USERMOD_DIR)
INC += -I$(JERRY_CORE)
INC += -I$(JERRY_DIR)/jerry-core/include
INC += -I$(JERRY_DIR)/jerry-ext/include
INC += -I$(JERRY_DIR)/jerry-port/default/include

INC += -I$(JERRY_CORE)/api
INC += -I$(JERRY_CORE)/debugger
INC += -I$(JERRY_CORE)/ecma/base
INC += -I$(JERRY_CORE)/ecma/builtin-objects
INC += -I$(JERRY_CORE)/ecma/operations
INC += -I$(JERRY_CORE)/jcontext
INC += -I$(JERRY_CORE)/jmem
INC += -I$(JERRY_CORE)/jrt
INC += -I$(JERRY_CORE)/lit
INC += -I$(JERRY_CORE)/parser/js
INC += -I$(JERRY_CORE)/parser/regexp
INC += -I$(JERRY_CORE)/vm

SRC_USERMOD_C += $(USERMOD_DIR)/modjerryscript.c

SRC_USERMOD_C += $(wildcard $(JERRY_CORE)/api/*.c)
SRC_USERMOD_C += $(wildcard $(JERRY_CORE)/debugger/*.c)
SRC_USERMOD_C += $(wildcard $(JERRY_CORE)/ecma/base/*.c)
SRC_USERMOD_C += $(wildcard $(JERRY_CORE)/ecma/builtin-objects/*.c)
SRC_USERMOD_C += $(wildcard $(JERRY_CORE)/ecma/operations/*.c)
SRC_USERMOD_C += $(wildcard $(JERRY_CORE)/jcontext/*.c)
SRC_USERMOD_C += $(wildcard $(JERRY_CORE)/jmem/*.c)
SRC_USERMOD_C += $(wildcard $(JERRY_CORE)/jrt/*.c)
SRC_USERMOD_C += $(wildcard $(JERRY_CORE)/lit/*.c)
SRC_USERMOD_C += $(wildcard $(JERRY_CORE)/parser/js/*.c)
SRC_USERMOD_C += $(wildcard $(JERRY_CORE)/parser/regexp/*.c)
SRC_USERMOD_C += $(wildcard $(JERRY_CORE)/vm/*.c)