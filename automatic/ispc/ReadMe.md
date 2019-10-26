﻿# <img src="https://cdn.jsdelivr.net/gh/chtof/chocolatey-packages/automatic/ispc/ispc.png" width="48" height="48"/> [Intel SPMD Program Compiler](https://chocolatey.org/packages/ispc)

## Overview
ispc is a compiler for a variant of the C programming language, with extensions for "single program, multiple data" (SPMD) programming. Under the SPMD model, the programmer writes a program that generally appears to be a regular serial program, though the execution model is actually that a number of program instances execute in parallel on the hardware. (See the ispc documentation for more details and examples that illustrate this concept.)

ispc compiles a C-based SPMD programming language to run on the SIMD units of CPUs and the Intel Xeon Phi™ architecture; it frequently provides a 3x or more speedup on CPUs with 4-wide vector SSE units and 5x-6x on CPUs with 8-wide AVX vector units, without any of the difficulty of writing intrinsics code. Parallelization across multiple cores is also supported by ispc, making it possible to write programs that achieve performance improvement that scales by both number of cores and vector unit size.

## Features
The Intel® SPMD Program Compiler (ispc) provides a number of key features to developers:

- _Familiarity as an extension of the C programming language:_ ispc supports familiar C syntax and programming idioms, while adding the ability to write SPMD programs.
- _High-quality SIMD code generation:_ the performance of code generated by ispc is often close to that of hand-written intrinsics code.
- _Ease of adoption with existing software systems:_ functions written in ispc directly interoperate with application functions written in C/C++ and with application data structures.
- _Portability across over a decade of CPU generations:_ ispc has targets for the Intel® SSE2, SSE4, AVX, and AVX2 instruction sets.
- _Portability across operating systems:_ Microsoft Windows, Mac OS X, and Linux are all supported by ispc.
- _Debugging with standard tools:_ ispc programs can be debugged with standard debuggers. OS X, Linux and Windows are supported (but debugging support on Windows is limitted).