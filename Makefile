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

all:TEST_OUT

TEST_OUT:
	mkdir -p $(OUT_DIR) $(LIB_DIR)
	$(CC) $(CPP_FLAGS) -I$(INC_DIR) $(TEST_SOURCE) -o $(OUT_DIR)/$(TEST_OUT).$(VERSION).$(SUFFIX)

.PHONY:	clean
clean:
	-rm -rf $(OUT_DIR)/* $(LIB_DIR)/*
