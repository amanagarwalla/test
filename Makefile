# Makefile for the Snake game

# Targets for different executable versions
all: snake_asm snake_asm_start

# Compile C source files
.c.o:
	gcc -Os -Wall -g -c $<

# Compile assembly source files
snake.o: snake.asm
	as -gstabs $^ -o $@

start.o: start.asm
	as -gstabs $^ -o $@

# Compile helpers.c into helpers.o
helpers.o: helpers.c
	gcc -Os -Wall -g -c helpers.c -o helpers.o

# Compile workaround.o (if needed for environment variables)
workaround.o: workaround.asm
	as -gstabs $^ -o $@

# Build the game to start from C main
snake_asm: main.o snake.o helpers.o workaround.o
	gcc $^ -o $@ -lncurses

# Build the game to start directly from assembly
snake_asm_start: start.o snake.o helpers.o workaround.o
	gcc $^ -o $@ -lncurses -lc -nostdlib

clean:
	rm -f *.o snake_asm snake_asm_start
