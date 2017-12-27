BINARY=asm8
CC=gcc
CFLAGS=-O3 -g -Wall -pedantic
LDFLAGS=-lm

CFILES=asm8.o utils.c line-processor.c parser.c assembler.c labels.c

.PHONY: clean

all: $(BINARY)

$(BINARY): asm8.o utils.o line-processor.o parser.o assembler.o labels.o
	${CC} ${CFLAGS} $^ ${LDFLAGS} -o ${BINARY}

#.c.o: terminal.h buffer.h aria.h api.h
#	$(CC) -c $(CFLAGS) $(CPPFLAGS) -o $@ $<

clean:
	rm -f *.o ${BINARY} nul

# for flymake
check-syntax:
	gcc -Wall -pedantic -o nul -S ${CHK_SOURCES}

make.depend: asm8.c utils.c utils.h line-processor.c line-processor.h parser.c parser.h assembler.c assembler.h labels.c labels.h
	touch make.depend
	makedepend -I/usr/include/linux -I/usr/lib/gcc/x86_64-linux-gnu/5/include/ -fmake.depend $^

-include make.depend
