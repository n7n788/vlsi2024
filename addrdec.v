`include "define.h"
module addrdec (
	input [`BUS_ADDR_WIDTH-1:0] addr,
	output cs0_, cs1_, cs2_, cs3_);

	assign cs0_ = (addr[9] == 0 && addr[8] == 0) ? `Enable_ : `Disable_;
	assign cs1_ = (addr[9] == 0 && addr[8] == 1) ? `Enable_ : `Disable_;
	assign cs2_ = (addr[9] == 1 && addr[8] == 0) ? `Enable_ : `Disable_;
	assign cs3_ = (addr[9] == 1 && addr[8] == 1) ? `Enable_ : `Disable_;
endmodule
