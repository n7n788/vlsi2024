`include "define.h"
module timer (
	input [`MEM_ADDR_WIDTH-1:0] addr,
	input [`DATA_WIDTH-1:0] idata,
	output [`DATA_WIDTH-1:0] odata,
	input cs_, input rw_, input clk);

	reg [31:0] count; reg en; wire clear, start, stop;

	assign clear = (cs_ == `Enable_ && rw_ == `Write && addr == 4 && idata == 1);
	assign start = (cs_ == `Enable_ && rw_ == `Write && addr == 4 && idata == 2);
	assign stop  = (cs_ == `Enable_ && rw_ == `Write && addr == 4 && idata == 4);

	always @ (posedge clk)
		if (clear) count <= 0;
		else if (en == `Enable) count <= count + 1;
	always @ (posedge clk) 
		if (start) en <= `Enable;
		else if (stop) en <= `Disable;
	
	assign odata = (cs_ == `Enable_ && rw_ == `Read && addr == 0) ? count[7:0] :
		       (cs_ == `Enable_ && rw_ == `Read && addr == 1) ? count[15:8] :
		       (cs_ == `Enable_ && rw_ == `Read && addr == 2) ? count[23:16] :
		       (cs_ == `Enable_ && rw_ == `Read && addr == 3) ? count[32:24] : 0;
endmodule
