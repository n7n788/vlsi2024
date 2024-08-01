`include "define.h"
module devices (
	input [`BUS_ADDR_WIDTH-1:0] addr,
	input [`DATA_WIDTH-1:0] idata,
	output [`DATA_WIDTH-1:0] odata,
	input rw_, reset_, clk);

	wire [`DATA_WIDTH-1:0] odata0, odata1, odata2, odata3;
	wire cs0_, cs1_, cs2_, cs3_;

	addrdec addrdec0(addr, cs0_, cs1_, cs2_, cs3_);
	sram sram0(addr[`MEM_ADDR_WIDTH-1:0], idata, odata0, cs0_, rw_, clk);
	sram sram1(addr[`MEM_ADDR_WIDTH-1:0], idata, odata1, cs1_, rw_, clk);
	timer timer0(addr[`MEM_ADDR_WIDTH-1:0], idata, odata2, cs2_, rw_, clk);
	timer timer1(addr[`MEM_ADDR_WIDTH-1:0], idata, odata3, cs3_, rw_, clk);

	assign odata = (cs0_ == `Enable_) ? odata0 : 
		       (cs1_ == `Enable_) ? odata1 : 
		       (cs2_ == `Enable_) ? odata2 :
		       (cs3_ == `Enable_) ? odata3 : 0;
endmodule
