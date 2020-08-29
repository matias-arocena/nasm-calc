# NASM-CALC

The goal of the project is to do a basic 16 bit calculator capable of doing substraction, addition and show a basic I/O menu.

## TODO
- [x] I/O menu handeling
- [ ] Create makefile (https://codereview.stackexchange.com/questions/156479/makefile-for-building-asm-c-project)
- [ ] Implement actual 16 bit substraction (Research Decimal Adjust Acumulator in NASM - DAA)
- [ ] Implement actual 16 bit addition
- [ ] Handle unexpected input

## Compilation
```
nasm -felf64 -g -dwarf calc.asm -o calc.o
ld calc.o -o calc
```
