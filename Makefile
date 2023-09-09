CXX=g++
AR=ar

CFLAGS=-std=c++11 -Iinclude/ -Ifreetype/include -DMSDFGEN_USE_CPP11
STATICS=freetype/objs/freetype.a

DIRS := core ext lib

SRC := $(wildcard $(addsuffix /*.cpp, $(DIRS)))
OBJ := $(patsubst %.cpp,bin/%.o,$(SRC))

LIBRARY := bin/libmsdfgen.a

all: freetype/objs/freetype.a $(LIBRARY)

$(LIBRARY): $(OBJ)
	echo $(SRC)
	$(AR) rcs $@ $^

bin/%.o: %.cpp
	if not exist bin/lib/ mkdir bin\lib
	if not exist bin/core/ mkdir bin\core
	if not exist bin/ext/ mkdir bin\ext
	$(CXX) $(CFLAGS) -c $< -o $@ $(STATICS)

freetype/objs/freetype.a:
	$(MAKE) -C freetype/