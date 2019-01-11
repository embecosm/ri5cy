# RI5CY: RISC-V Core

This is a fork of the
[PULP Platform RI5CY core](https://github.com/pulp-platform/riscv) for
Verilator and GDB server development.
**All essential parts developed in here have been merged back and are available 
in the upstream repository.**

RI5CY is a small 4-stage RISC-V core. It starte its life as a
fork of the OR10N cpu core that is based on the OpenRISC ISA.

RI5CY fully implements the RV32I instruction set, the multiply instruction from
RV32M and many custom instruction set extensions that improve its performance
for signal processing applications.

The core was developed as part of the [PULP platform](http://pulp.ethz.ch/) for
energy-efficient computing and is currently used as the processing core for
PULP and PULPino.

## Documentation

A datasheet that explains the most important features of the core can be found
in `docs/datasheet/`.

It is written using LaTeX and can be generated as follows

    make all

## Verilator model

The Verilator model can be built at the top level using

    make all

The RI5CY code uses some quite advanced System Verilog, so you will need a
very up to date Verilator. We succeeded with development version 3.905, but
found version 3.900 crashed.

## Licensing

The upstream design is all licensed under the SolderPad License v 0.51, see
the file LICENSE.solderpad.

The modifications by Embecosm to support Verilator modeling and implement a
GDB server are licensed under the GNU General Public License 3.0, see the file
LICENSE.GPL3.

The headers for source files should indicate which license applies. If no
license is specified, then the solderPad license should be assumed.
