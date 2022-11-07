VERSION=1.0.0
SUFFIX=out

# include head dir
INC_DIR=./inc

# src file
SRC_DIR=

# lib dir
LIB_DIR=./lib

# out dir
OUT_DIR=./out

# test module
TEST_DIR=./test
TEST_SOURCE=$(TEST_DIR)/Test.cpp
TEST_TARGET=Test.o
TEST_OUT=Test

# compiler
CC=g++

# linker
LD=ld

# C flags
C_FLAGS=
CPP_FLAGS= -std=c++11

# documentation for Sphinx
# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS ?=
SPHINXBUILD ?= sphinx-build
DOCUMENTAION_SOURCE_DIR = docs
DOCUMENTAION_BUILD_DIR = docs/out

all:TEST_OUT

TEST_OUT:
	mkdir -p $(OUT_DIR) $(LIB_DIR)
	$(CC) $(CPP_FLAGS) -I$(INC_DIR) $(TEST_SOURCE) -o $(OUT_DIR)/$(TEST_OUT).$(VERSION).$(SUFFIX)

.PHONY:	clean htmldocs cleandocs

clean:
	-rm -rf $(OUT_DIR)/* $(LIB_DIR)/*

htmldocs:
	$(SPHINXBUILD) -M html "$(DOCUMENTAION_SOURCE_DIR)" "$(DOCUMENTAION_BUILD_DIR)" $(SPHINXOPTS) $(O)

cleandocs:
	-rm -rf $(DOCUMENTAION_BUILD_DIR)
