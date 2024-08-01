//-------------------------------------------------------
// test.v
// Max Yi (byyi@hmc.edu) and David_Harris@hmc.edu 12/9/03
// Model of subset of MIPS processor described in Ch 1
//
// Matsutani: SDF annotation is added
// Matsutani: datapath width is changed to 32-bit
//-------------------------------------------------------
`timescale 1ns/10ps
`include "define.h"
/* top level design for testing */
// Modified by Matsutani
//module top #(parameter WIDTH = 8, REGBITS = 3) ();
module test32 ();
reg			clk;
reg			reset_;
// 10nsec --> 100MHz
parameter STEP = 10.0;
// instantiate devices to be tested
//mips #(WIDTH, REGBITS) dut(clk, reset, memdata, memread, memwrite, adr, writedata);
top top0(reset_, clk);
// external memory for code and data
// exmemory #(WIDTH) exmem(clk, memwrite, adr, writedata, memdata);
// initialize test
initial begin
`ifdef __POST_PR__
	$sdf_annotate("mips32.sdf", top0 , "sdf.log", "MAXIMUM");
`endif
	$readmemh("test32.dat", top0.devices0.sram0.mem, 0, 18);
	// dump waveform
	$dumpfile("dump.vcd");
	$dumpvars(0, top0);
	// reset
	clk <= 0; reset_ <= `Enable_; # 15; reset_ <= `Disable_;
	// stop at 1,000 cycles
	#(STEP*1000);
	$display("Simulation failed");
	$finish;
end
// generate clock to sequence tests
always #(STEP / 2)
	clk <= ~clk;
always @(negedge clk) begin
	if (top0.dut0.memwrite) begin
		$display("Data [%d] is stored in Address [%d]", 
			top0.dut0.adr, top0.dut0.writedata);
		// Modified by Matsutani
		//if (adr == 5 & writedata == 7)
		if (top0.dut0.adr == 20 & top0.dut0.writedata == 7)
		//
			$display("Simulation completely successful");
		else
			$display("Simulation failed");
		$finish;
	end
end
endmodule

/* external memory accessed by MIPS */
// module exmemory #(parameter WIDTH = 8) (
// 	input			clk,
// 	input			memwrite,
// 	input [WIDTH-1:0]	adr, writedata,
// 	output reg [WIDTH-1:0]	memdata
// );
// // Modified by Matsutani
// //reg [31:0]	RAM [(1<<WIDTH-2)-1:0];
// reg [31:0]	RAM [255:0];
// //
// wire [31:0]	word;
// //integer	i;
// initial begin
// 	// Modified by Matsutani
// 	//for (i = 0; i < (1<<WIDTH-2); i = i + 1)
// 	//	RAM[i] = 0;
// 	//$readmemh("mipstest.dat", RAM);
// 	$readmemh("test32.dat", RAM);
// 	//
// end
// // read and write bytes from 32-bit word
// always @(posedge clk)
// 	if (memwrite) 
// 		// Modified by Matsutani
// 		//case (adr[1:0])
// 		//	2'b00: RAM[adr>>2][31:24]   <= writedata;
// 		//	2'b01: RAM[adr>>2][23:16]  <= writedata;
// 		//	2'b10: RAM[adr>>2][15:8] <= writedata;
// 		//	2'b11: RAM[adr>>2][7:0] <= writedata;
// 		//endcase
// 		RAM[adr>>2][31:0] <= writedata;
// 		//
// assign word = RAM[adr>>2];
// always @(*)
// 	// Modified by Matsutani
// 	//case (adr[1:0])
// 	//	2'b00: memdata <= word[31:24];
// 	//	2'b01: memdata <= word[23:16];
// 	//	2'b10: memdata <= word[15:8];
// 	//	2'b11: memdata <= word[7:0];
// 	//endcase
// 	memdata <= word[31:0];
// 	//
// endmodule
