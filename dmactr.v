module dmactr (
	// Signals between DMAC and devices
	output reg [`BUS_ADDR_WIDTH-1:0] addr, // Memory or I/O address
	output reg [`DATA_WIDTH-1:0]      odata, // Write data
	input [`DATA_WIDTH-1:0]       idata, // Read data
	output reg		      rw_, // Read/write signal
	// Signals between DMAC and bus arbiter
	output reg	 	      breq_, // Bus request
	input 		  	      bgrt_, // Bus grant
	// Signals between DMAC and CPM (DMA configuration)
	input [`BUS_ADDR_WIDTH-1:0]   dsaddr, // DMA source address
	input [`BUS_ADDR_WIDTH-1:0]   ddaddr, // DMA destination address
	input [1:0] 		      dmode, // DMA transfer mode
	input 			      dreq_, // DMA request (*)
	input [`BUS_ADDR_WIDTH-1:0]     dcount, // DMA transmission count
	output reg		      eop_, // DMA complete
	input 			      reset_, 
	input 		              clk);

	reg [1:0] state;	
	reg [`BUS_ADDR_WIDTH-1:0] count;
	// Once dreq_ is asserted, assert breq_ and wait until bgrt_ is asserted
	
	// Once bgrt_ is asserted, start DMA transfer
	
	// (Read a single word from dsaddr and write it to ddaddr)
	
	always @ (posedge clk)
		if (reset_ == `Enable_) begin
			state <= `COMPLETE;	
			breq_ <= `Disable_;
			count <= 0;
		end
		else case (state)
			`WAIT : if (dreq_ == `Enable_) begin
					count <= 0;
					breq_ <= `Enable_;
					eop_ <= `Disable_;
					state <= `READ1;
				end	
			`READ1: if (bgrt_ == `Enable_) begin
					if (dmode == 2'b01 || dmode == 2'b10) addr <= dsaddr + count;
					else addr <= dsaddr;
					rw_ <= `Read;
					state <= `WRITE1;
				end		
			`WRITE1: begin
					if (dmode == 2'b01 || dmode == 2'b11) addr <= ddaddr + count;
					else addr <= ddaddr;
					rw_    <= `Write;
					odata <= idata;
					count <= count + 1;
					if (dmode == 2'b00 || count >= dcount) state <= `COMPLETE;
					else state <= `READ1;
				end
			`COMPLETE: begin
					eop_   <= `Enable_;
					breq_  <= `Disable_;
					state <= `WAIT;
				end
		endcase
endmodule
