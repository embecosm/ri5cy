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

# Testbench

SRC = testbench.cpp

OBJS = testbench.o

EXE = testbench

# top module name

TOP = top

# Verilator elements

VSRC = cluster_clock_gating.sv            \
       dp_ram.sv                          \
       ram.sv                             \
       top.sv                             \
       ../include/apu_core_package.sv     \
       ../include/riscv_defines.sv        \
       ../include/riscv_tracer_defines.sv \
       ../riscv_alu.sv                    \
       ../riscv_alu_basic.sv              \
       ../riscv_alu_div.sv                \
       ../riscv_compressed_decoder.sv     \
       ../riscv_controller.sv             \
       ../riscv_cs_registers.sv           \
       ../riscv_debug_unit.sv             \
       ../riscv_decoder.sv                \
       ../riscv_int_controller.sv         \
       ../riscv_ex_stage.sv               \
       ../riscv_hwloop_controller.sv      \
       ../riscv_hwloop_regs.sv            \
       ../riscv_id_stage.sv               \
       ../riscv_if_stage.sv               \
       ../riscv_load_store_unit.sv        \
       ../riscv_mult.sv                   \
       ../riscv_prefetch_buffer.sv        \
       ../riscv_prefetch_L0_buffer.sv     \
       ../riscv_register_file.sv          \
       ../riscv_core.sv                   \
       ../riscv_apu_disp.sv               \
       ../riscv_L0_buffer.sv

VINC = ../include

VSMK = V$(TOP).mk
VMK  = $(VDIR)/$(VSMK)

# Build the executable

$(VDIR)/$(TOP): $(VDIR) $(VMK)
	$(MAKE) -C $(VDIR) -f $(VSMK)

$(VDIR):
	mkdir -p $@

$(VMK): $(VSRC)
	verilator -O3 -CFLAGS "-O3 -g3 -std=gnu++11" \
                  -Wno-CASEINCOMPLETE -Wno-LITENDIAN -Wno-UNOPT \
	          -Wno-UNOPTFLAT -Wno-WIDTH -Wno-fatal --top-module top \
	          --Mdir $(VDIR) --trace -DPULP_FPGA_EMUL -cc \
	          +incdir+$(VINC) $(VSRC) $(SRC) --exe

.PHONY: clean
clean:
	$(RM) -r $(VDIR)
	$(RM) $(EXE) $(OBJS)
