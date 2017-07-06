# Makefile for Verilator model of RI5CY

# Copyright (C) 2017 Embecosm Limited <www.embecosm.com>

# Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.

# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <http://www.gnu.org/licenses/>.

# Tools

# PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/opt/verilator-HEAD/share/pkgconfig"
VERILATOR = verilator
VDIR = obj_dir
CPPFLAGS = -I$(VDIR) `pkg-config --cflags verilator`
CXXFLAGS = -Wall -Werror -std=c++11
CXX = g++
LD = g++

# Binaries

EXE = testbench

OBJS = testbench.o

# top module name

TOP = top

# Verilator elements

VSRC = ../include/riscv_defines.sv        \
       ../include/riscv_tracer_defines.sv \
       ../alu.sv                          \
       ../alu_div.sv                      \
       cluster_clock_gating.sv            \
       ../compressed_decoder.sv           \
       ../controller.sv                   \
       ../cs_registers.sv                 \
       ../debug_unit.sv                   \
       ../decoder.sv                      \
       dp_ram.sv                          \
       ../exc_controller.sv               \
       ../ex_stage.sv                     \
       ../hwloop_controller.sv            \
       ../hwloop_regs.sv                  \
       ../id_stage.sv                     \
       ../if_stage.sv                     \
       ../load_store_unit.sv              \
       ../mult.sv                         \
       ../prefetch_buffer.sv              \
       ../prefetch_L0_buffer.sv           \
       ram.sv                             \
       ../riscv_core.sv                   \
       ../register_file_ff.sv             \
       top.sv
VINC = ../include

# May also want:
#   $(VDIR)/verilated_dpi.o

VOBJS = $(VDIR)/verilated.o       \
        $(VDIR)/verilated_vcd_c.o

VLIB = $(VDIR)/V$(TOP)__ALL.a

VSMK = V$(TOP).mk
VMK  = $(VDIR)/$(VSMK)

# Build the executable

$(EXE): $(VLIB) $(VOBJS) $(OBJS)
	$(LD) -o $@ $(OBJS) $(VLIB) $(VOBJS)

$(VOBJS): $(VMK)
	for f in $@; \
	do \
		sf=$$(basename $$f); \
		$(MAKE) -C $(VDIR) -f $(VSMK) $$sf; \
	done

$(VLIB): $(VMK)
	make -C $(VDIR) -f V$(TOP).mk

$(VMK): $(VSRC)
	verilator -O3 -CFLAGS "-O3 -g3" \
                  -Wno-CASEINCOMPLETE -Wno-LITENDIAN -Wno-UNOPT \
	          -Wno-UNOPTFLAT -Wno-WIDTH -Wno-fatal --top-module top \
	          --Mdir $(VDIR) --trace -DPULP_FPGA_EMUL -cc \
	          +incdir+$(VINC) $(VSRC)

.PHONY: clean
clean:
	$(RM) -r $(VDIR)
	$(RM) $(OBJS)
	$(RM) $(EXE)
