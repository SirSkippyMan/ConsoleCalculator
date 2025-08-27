# Makefile
# This compiles the flex, bison, and C files for the calculator program.
#
# @author: Josh Nygaard (joshdn03@gmail.com)
# @version: 1.1

all:
	bison -d calc.y
	flex -o calc.yy.c calc.l
	gcc -o calc calc.tab.c calc.yy.c -lm

clean:

	rm -f calc *.c
