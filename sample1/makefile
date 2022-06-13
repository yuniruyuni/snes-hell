BIN=sample1.smc
SRC=sample1.asm
CFG=sample1.cfg
OBJ=$(SRC:.asm=.o)
LIB=

all: $(OBJ) $(LIB)
	ld65 -o $(BIN) --config $(CFG) --obj $(OBJ)

.SUFFIXES: .asm .o

.asm.o:
	cl65 -t none -o $*.o -c $*.asm

clean:
	rm *.smc
	rm *.o
