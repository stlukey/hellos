hellos
======

A Simple Hello World Kernel.


Running
=======

Given that qemu is installed just run:
```
make run hello
```

Info
====

All code is in hello.asm which is < 50 lines of code.
I/O is accomplished through `ìnt 10h` BIOS interrupt call.
