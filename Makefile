VERSION = 1.0.0
SUFFIX = out

# include head dir
INC_DIR = ./inc
ADD_INCLUDES_DIR = $(INC_DIR)/Add

INC_TEST_DIR = ./test
MODULE_DEMO_DIR = $(INC_TEST_DIR)/ModuleDemo

INCLUDES = -I$(INC_DIR) -I$(ADD_INCLUDES_DIR) -I$(MODULE_DEMO_DIR)

# src file
SRC_DIR = ./src
ADD_SOURCES_DIR = $(SRC_DIR)/Add

ADD_SOURCES = $(ADD_SOURCES_DIR)/Add.cpp

SOURCES = $(ADD_SOURCES)

# lib dir
LIB_DIR = ./lib
LIB_PATH = -L$(LIB_DIR)

ADD_LIB = add

# out dir
OUT_DIR = ./out

# test module
TEST_DIR = ./test
TEST_SOURCE = $(TEST_DIR)/Test.cpp
TEST_TARGET = Test

# compiler
CC = g++

# linker
LD = ld

# C flags
C_FLAGS =
CPP_FLAGS = -std=c++17 -Wall

# libs
LIBS = -l$(ADD_LIB)

# internal macro
INTERNAL_MACRO = -DLINUX_VERSION

# debug macro
DEBUG_MACRO = -D_DEBUG_

# documentation for Sphinx
# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS ?=
SPHINXBUILD ?= sphinx-build
DOCUMENTAION_SOURCE_DIR = docs
DOCUMENTAION_BUILD_DIR = docs/out

ALL_TARGET = $(TEST_TARGET) $(ADD_LIB)

all: $(ALL_TARGET)

$(TEST_TARGET): $(TEST_SOURCE) $(ADD_LIB)
	mkdir -p $(OUT_DIR) $(LIB_DIR)
	$(CC) $(INCLUDES) $(INTERNAL_MACRO) $(DEBUG_MACRO) $(CPP_FLAGS) $(LIB_PATH) $(LIBS) $(TEST_SOURCE) -o \
		$(OUT_DIR)/$(TEST_TARGET).$(VERSION).$(SUFFIX)

$(ADD_LIB): $(ADD_SOURCES)
	mkdir -p $(LIB_DIR)
	$(CC) $(INCLUDES) $(INTERNAL_MACRO) $(DEBUG_MACRO) $(CPP_FLAGS) -fPIC -shared $(ADD_SOURCES) -o \
		$(LIB_DIR)/lib$(ADD_LIB).so

.PHONY:	clean htmldocs cleandocs

clean:
	-rm -rf $(OUT_DIR)/* $(LIB_DIR)/*

htmldocs:
	$(SPHINXBUILD) -M html "$(DOCUMENTAION_SOURCE_DIR)" "$(DOCUMENTAION_BUILD_DIR)" $(SPHINXOPTS) $(O)

cleandocs:
	-rm -rf $(DOCUMENTAION_BUILD_DIR)
