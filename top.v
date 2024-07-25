`timescale 1ns/10ps

/* top level design for testing */
// Modified by Matsutani
//module top #(parameter WIDTH = 8, REGBITS = 3) ();
`include "define.h"
module top (
	input reset_, input clk);

    // CPU0とdevicesの間の入出力
    wire			memread0, memwrite0, rw0_;
    wire [`BUS_ADDR_WIDTH-1:0] addr0;
    wire [`DATA_WIDTH-1:0]	idata0, odata0; // devicesへの入力/出力
	// CPU0とbusarbの間の入出力
    wire breq0_, bgrt0_;

    // CPU1のdevicesの間の入出力
    wire			memread1, memwrite1, rw1_;
    wire [`BUS_ADDR_WIDTH-1:0]	addr1;
    wire [`DATA_WIDTH-1:0]	idata1, odata1; // devicesへの入力/出力
	// CPU1とbusarbの間の入出力
    wire breq1_, bgrt1_;

    // devicesとの入出力
    wire [`BUS_ADDR_WIDTH-1:0] addr;
	wire [`DATA_WIDTH-1:0] idata, odata;
    wire rw_;
    
    assign rw0_ = memread0 ? `Read : 
                  memwrite0 ? `Write: `Read;
    assign rw1_ = memread1 ? `Read : 
                  memwrite1 ? `Write: `Read;

	assign odata0 = odata; assign odata1 = odata;

	// addr0 or addr1 depending on bgrt
	assign addr  = (bgrt0_ == `Enable_) ? addr0  : 
	 	       (bgrt1_ == `Enable_) ? addr1  : addr0;
	assign idata = (bgrt0_ == `Enable_) ? idata0 :
		       (bgrt1_ == `Enable_) ? idata1 : idata0;// idata0 or idata1 depending on bgrt
	assign rw_   = (bgrt0_ == `Enable_) ? rw0_   :
		       (bgrt1_ == `Enable_) ? rw1_   : rw0_;// rw0_ or rw1_ depending on bgrt
	
	devices devices0 (addr, idata, odata, rw_, reset_, clk);
	busarb busarb0 (breq0_, breq1_, bgrt0_, bgrt1_, reset_, clk);
    mips32 dut0(clk, reset_, odata0, bgrt0_, memread0, memwrite0, addr0, idata0, breq0_);
    mips32 dut1(clk, reset_, odata1, bgrt1_, memread1, memwrite1, addr1, idata1, breq1_);
endmodule
