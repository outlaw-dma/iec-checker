# IEC Checker

![](https://github.com/jubnzv/iec-checker/workflows/Unit%20tests/badge.svg)

This project aims to implement an open source tool for static code analysis of IEC61131-3 programs.

The following features are currently implemented:
+ IEC61131-3 3 ed. parser for [Structured Text](https://en.wikipedia.org/wiki/Structured_text) written using modern [menhir](http://gallium.inria.fr/~fpottier/menhir/) syntax. Almost all IEC syntax constructions are supported, excluding some user-defines types and OO features.
+ Some checks for [PLCOpen Guidelines](https://plcopen.org/software-construction-guidelines);
+ Simple declaration analysis;
+ Control flow analysis (WIP);
+ Ability to dump AST of the IEC program into JSON file (`-dump true` argument);

## Installation

For development you need to install [ocaml](https://ocaml.org/docs/install.html) environment and [dune](https://dune.readthedocs.io/en/stable/quick-start.html) build system:
```bash
opam switch create 4.08.1
opam install dune
```

Building and installing OCaml package to the current directory:
```bash
dune build @install
dune install --preifx ./output
```

You will also need a Python interpreter with some additional packages:
```bash
apt-get install python3 python3-virtualenv
virtualenv venv --python=/usr/bin/python3
source venv/bin/activate
pip3 install -r requirements.txt
```

Running unit tests:
```bash
pip3 install -r requirements-dev.txt
pytest
```

## Usage

Check some demo programs written in Structured Text:
```bash
python3 checker.py test/st/*.st
```

This will gives you the following output:
```
Report for test/st/cfg.st:
No errors found!
Report for test/st/dead-code.st:
[PLCOPEN-L17] 11:8 Each IF instruction should have an ELSE clause
[PLCOPEN-L17] 15:8 Each IF instruction should have an ELSE clause
Report for test/st/declaration-analysis.st:
[DeclarationAnalysis] Initial subrange value -4096 does not fit specified range (-4095 .. 4095)
[DeclarationAnalysis] Initial subrange value 4099 does not fit specified range (-4095 .. 4095)
[DeclarationAnalysis] Length of initialization string literal exceeds string length (6 > 5)
Report for test/st/plcopen-cp13.st:
[PLCOPEN-CP13] 8:31 POUs shall not call themselves directly or indirectly
Report for test/st/plcopen-l17.st:
[PLCOPEN-L17] 10:4 Each IF instruction should have an ELSE clause
Report for test/st/plcopen-n3.st:
[PLCOPEN-N3] 6:7 IEC data types and standard library objects must be avoided
Report for test/st/zero-division.st:
[ZeroDivision] 7:12 Constant 19 is divided to zero!
[ZeroDivision] 9:14 Variable Var2 is divided to zero!
```
