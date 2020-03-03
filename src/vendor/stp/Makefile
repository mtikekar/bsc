TOP=../../..
PREFIX?=$(TOP)/inst

include $(TOP)/platform.mk

.PHONY: all install clean full_clean

ifeq ($(STP_STUB),)
SRC = src
ifeq ($(OSTYPE),Darwin)
CC = gcc-9
CXX = g++-9
endif
else
SRC = src_stub
endif

all: install

install:
	$(MAKE) -C $(SRC) CC=$(CC) CXX=$(CXX) install
	ln -fsn HaskellIfc include_hs
	install -m 755 -d $(PREFIX)/lib/SAT
	install -m 644 lib/* $(PREFIX)/lib/SAT

clean:
	$(MAKE) -C $(SRC) clean

full_clean:
	$(MAKE) -C $(SRC) full_clean
	rm -f include_hs
