# Elixir C Compiler

**This is a nice small C subset compiler implemented in Elixir.**

This project is inspired by the C Compiler proposed by Nora Sandler, it includes the functionalities up to the fourth phase.
You can review Nora's proposals here: https://norasandler.com/

The objective of this repository is to make public the work done in the Code Synaptics team developing a compiler, in order to demonstrate our skills. The work was carried out from August 25, 2022 to January 12, 2023. You can consult the Project Plan folder for the distribution of work in the team.
This software was the result of the Compilers course at the UNAM Faculty of Engineering, taught by Eng. Norberto Jesús Ortigoza Márquez, this being our Customer.

## Installation
Note: It only work's on Linux systems.

1. git clone https://github.com/dargleon/elixir-c-compiler
2. cd elixir-c-compiler
3. mix escript.build

## Using

./nqcc file_name.c

## Execution options

The compiler supports following options:

./nqcc --A file_name.c&nbsp;&nbsp;&nbsp;&nbsp;Compile and display scanner, parser and code generator output<br>
./nqcc --L file_name.c&nbsp;&nbsp;&nbsp;&nbsp;Compile and display scanner output<br>
./nqcc --P file_name.c&nbsp;&nbsp;&nbsp;&nbsp;Compile and display parser output<br>
./nqcc --S file_name.c&nbsp;&nbsp;&nbsp;&nbsp;Compile and display generator output<br>
./nqcc --help&nbsp;&nbsp;&nbsp;&nbsp;Prints this help<br>

## Examples
Check th examples folder to test our Compiler

- $ ./nqcc ./examples/return_2.c
