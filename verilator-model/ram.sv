// RAM wrapper for RI5CY

// Copyright (C) 2017 Embecosm <www.embecosm.com>

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.

// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.

// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


// This maps the dp_ram module of pulpino to the instruction and data ports of
// the RI5CY processor core.

// 4MB of RAM, matching the PicoRV32 implementation.

module ram
    #(
    parameter ADDR_WIDTH = 22
  )(
    // Clock
    input  logic                   clk,

    input  logic                   instr_req_i,
    input  logic [ADDR_WIDTH-1:0]  instr_addr_i,
    output logic [127:0]           instr_rdata_o,
    output logic                   instr_rvalid_o,
    output logic                   instr_gnt_o,

    input  logic                   data_req_i,
    input  logic [ADDR_WIDTH-1:0]  data_addr_i,
    input  logic                   data_we_i,
    input  logic [3:0]             data_be_i,
    input  logic [31:0]            data_wdata_i,
    output logic [31:0]            data_rdata_o,
    output logic                   data_rvalid_o,
    output logic                   data_gnt_o
  );

   // Instantiate the ram

   dp_ram
     #(
       .ADDR_WIDTH (ADDR_WIDTH)
       )
   dp_ram_i
     (
      .clk       ( clk           ),

      .en_a_i    ( instr_req_i   ),
      .addr_a_i  ( instr_addr_i  ),
      .wdata_a_i ( '0            ),	// Not writing so ignored
      .rdata_a_o ( instr_rdata_o ),
      .we_a_i    ( '0            ),
      .be_a_i    ( 4'b1111       ),	// Always want 32-bits

      .en_b_i    ( data_req_i    ),
      .addr_b_i  ( data_addr_i   ),
      .wdata_b_i ( data_wdata_i  ),
      .rdata_b_o ( data_rdata_o  ),
      .we_b_i    ( data_we_i     ),
      .be_b_i    ( data_be_i     )
      );

   assign data_gnt_o  = data_req_i;
   assign instr_gnt_o = instr_req_i;

   always_ff @(posedge clk)
     begin
	data_rvalid_o  <= data_req_i;
	instr_rvalid_o <= instr_req_i;
     end

endmodule	// ram
