//-------------------------------------------------------
// mips.v
// Max Yi (byyi@hmc.edu) and David_Harris@hmc.edu 12/9/03
// Model of subset of MIPS processor described in Ch 1
//
// Matsutani: ADDI instruction is added
// Matsutani: datapath width is changed to 32-bit
//-------------------------------------------------------

/* simplified MIPS processor */
// Modified by Matsutani
//module mips #(parameter WIDTH = 8, `REGBITS = 3) (
`include "define.h"
module mips32 (
	input			clk, reset_,
	input [`DATA_WIDTH-1:0] 	memdata,
	input 			bgrt_,
	output			memread, memwrite,
	output [`BUS_ADDR_WIDTH-1:0] adr,
	output [`DATA_WIDTH-1:0] writedata,
	output 			breq_
);
wire [31:0]	instr;
wire		zero, alusrca, memtoreg, iord, pcen, regwrite, regdst;
wire [1:0]	aluop, pcsource, alusrcb;
wire [3:0]	irwrite;
wire [2:0]	alucont;
controller cont(clk, reset_, instr[31:26], zero, bgrt_, memread, memwrite,
			alusrca, memtoreg, iord, pcen, regwrite, regdst,
			pcsource, alusrcb, aluop, irwrite, breq_);
alucontrol ac(aluop, instr[5:0], alucont);
datapath dp(clk, reset_, memdata, alusrca, memtoreg,
			iord, pcen, regwrite, regdst, pcsource, alusrcb,
			irwrite, alucont, zero, instr, adr, writedata);
endmodule

/* controller */
module controller (
	input			clk, reset_,
	input [5:0]		op,
	input			zero,
	input			bgrt_,
	output reg		memread, memwrite, alusrca, memtoreg, iord,
	output			pcen,
	output reg		regwrite, regdst,
	output reg [1:0]	pcsource, alusrcb, aluop,
	output reg [3:0]	irwrite,
	output reg		breq_
);
parameter FETCH1      = 4'b0001;
parameter SAME_FETCH1 = 4'b0010;
parameter SAME_LBRD   = 4'b0011;
parameter SAME_SBWR   = 4'b0100;
parameter DECODE      = 4'b0101;
parameter MEMADR      = 4'b0110;
parameter LBRD        = 4'b0111;
parameter LBWR        = 4'b1000;
parameter SBWR        = 4'b1001;
parameter RTYPEEX     = 4'b1010;
parameter RTYPEWR     = 4'b1011;
parameter BEQEX       = 4'b1100;
parameter JEX         = 4'b1101;
parameter ADDIEX      = 4'b1110;
parameter ADDIWR      = 4'b1111;
parameter LB          = 6'b100000;
parameter SB          = 6'b101000;
// op(命令の上位6bit)の値
// Added by Matsutani
parameter LW      = 6'b100011;
parameter SW      = 6'b101011;
//
parameter RTYPE   = 6'b0;
parameter BEQ     = 6'b000100;
parameter ADDI    = 6'b001000;
parameter J       = 6'b000010;
reg [3:0]	state, nextstate;
reg		pcwrite, pcwritecond;
// assign breq_ = (memread | memwrite) ? `Enable_ : `Disable_;
// state register
always @(posedge clk)
	if (reset_ == `Enable_) state <= FETCH1;
	else state <= nextstate;
// next state logic
always @(*) begin
	case (state)
		// Modified by Matsutani
		//FETCH1:	nextstate <= FETCH2;
		FETCH1:	begin
			if (bgrt_ == `Enable_) nextstate <= DECODE;
			else nextstate <= FETCH1;
		end
		//FETCH2:	nextstate <= FETCH3;
		//FETCH3:	nextstate <= FETCH4;
		//FETCH4:	nextstate <= DECODE;
		// SAME_FETCH1: begin
		// 	if (bgrt_ == `Enable_) nextstate <= DECODE;
		// 	else nextstate <= SAME_FETCH1;
		// end
		DECODE:	case (op)
			LB:	nextstate <= MEMADR;
			SB:	nextstate <= MEMADR;
			// Added by Matsutani
			LW:	nextstate <= MEMADR;
			SW:	nextstate <= MEMADR;
			//
			RTYPE:	nextstate <= RTYPEEX;
			BEQ:	nextstate <= BEQEX;
			ADDI:	nextstate <= ADDIEX;
			J:	nextstate <= JEX;
			default:nextstate <= FETCH1; // should never happen
		endcase
		MEMADR: begin
			case (op)
				LB:	nextstate <= LBRD;
				SB:	nextstate <= SBWR;
				// Added by Matsutani
				LW:	nextstate <= LBRD;
				SW:	nextstate <= SBWR;
				default:nextstate <= FETCH1; // should never happen
			endcase
		end
		LBRD: begin
			if (bgrt_ == `Enable_) nextstate <= LBWR;
			else nextstate <= LBRD;
		end 
		LBWR:	nextstate <= FETCH1;
		SBWR: begin
			if (bgrt_ == `Enable_) nextstate <= FETCH1;
			else nextstate <= SBWR;
		end
		RTYPEEX:nextstate <= RTYPEWR;
		RTYPEWR:nextstate <= FETCH1;
		BEQEX:	nextstate <= FETCH1;
		JEX:	nextstate <= FETCH1;
		ADDIEX: nextstate <= ADDIWR;
		ADDIWR:	nextstate <= FETCH1;
		default:nextstate <= FETCH1; // should never happen
	endcase
end
always @(*) begin
	// set all outputs to zero,
	// then conditionally assert just the appropriate ones
	irwrite <= 4'b0000;
	pcwrite <= 0; pcwritecond <= 0;
	regwrite <= 0; regdst <= 0;
	memread <= 0; memwrite <= 0;
	alusrca <= 0; alusrcb <= 2'b00; aluop <= 2'b00;
	pcsource <= 2'b00;
	iord <= 0; memtoreg <= 0;
	breq_ <= `Disable_;
	case (state)
		FETCH1: begin
			memread <= 1;
			irwrite <= 4'b1000;
			alusrcb <= 2'b01;
			pcwrite <= 1;
			breq_ <= `Enable_;
		end
		// SAME_FETCH1: begin
		// 	memread <= 1;
		// 	irwrite <= 4'b1000;
		// 	alusrcb <= 2'b01;
		// 	breq_ <= `Enable_;
		// end
		// FETCH3: begin
		// 	memread <= 1;
		// 	irwrite <= 4'b0010;
		// 	alusrcb <= 2'b01;
		// 	pcwrite <= 1;
		// end
		// FETCH4: begin
		// 	memread <= 1;
		// 	irwrite <= 4'b0001;
		// 	alusrcb <= 2'b01;
		// 	pcwrite <= 1;
		// end
		DECODE: begin 
			alusrcb <= 2'b11;
		end
		MEMADR: begin
			alusrca <= 1;
			alusrcb <= 2'b10;
		end
		LBRD: begin
			memread <= 1;
			iord    <= 1;
			breq_ <= `Enable_;
		end
		LBWR: begin
			regwrite <= 1;
			memtoreg <= 1;
		end
		SBWR: begin
			memwrite <= 1;
			iord     <= 1;
			breq_ <= `Enable_;
		end
		RTYPEEX: begin
			alusrca <= 1;
			aluop   <= 2'b10;
		end
		RTYPEWR: begin
			regdst   <= 1;
			regwrite <= 1;
		end
		BEQEX: begin
			alusrca     <= 1;
			aluop       <= 2'b01;
			pcwritecond <= 1;
			pcsource    <= 2'b01;
		end
		JEX: begin
			pcwrite  <= 1;
			pcsource <= 2'b10;
		end
		ADDIEX: begin
			alusrca <= 1;
			alusrcb <= 2'b10;
		end
		ADDIWR: begin
			regdst   <= 0;
			regwrite <= 1;
		end
	endcase
end
assign pcen = pcwrite | (pcwritecond & zero); // program counter enable
endmodule

/* alucontrol */
module alucontrol (
	input [1:0]		aluop,
	input [5:0]		funct,
	output reg [2:0]	alucont
);
always @(*)
	case (aluop)
		2'b00:	alucont <= 3'b010; // add for lb/sb/addi
		2'b01:	alucont <= 3'b110; // sub (for beq)
		default: case (funct) // R-Type instructions
			6'b100000: alucont <= 3'b010; // add (for add)
			6'b100010: alucont <= 3'b110; // subtract (for sub)
			6'b100100: alucont <= 3'b000; // logical and (for and)
			6'b100101: alucont <= 3'b001; // logical or (for or)
			6'b101010: alucont <= 3'b111; // set on less (for slt)
			default:   alucont <= 3'b101; // should never happen
		endcase
	endcase
endmodule

/* datapath */
module datapath (
	input			clk, reset_,
	input [`DATA_WIDTH-1:0]	memdata,
	input			alusrca, memtoreg, iord, pcen, regwrite, regdst,
	input [1:0]		pcsource, alusrcb,
	input [3:0]		irwrite,
	input [2:0]		alucont,
	output			zero,
	output [31:0]		instr,
	output [`BUS_ADDR_WIDTH-1:0]	adr,
	output [`DATA_WIDTH-1:0]	 writedata
	
);
// the size of the parameters must be changed to match the DATA_WIDTH parameter
// Modified by Matsutani
//parameter CONST_ZERO = 8'b0;
//parameter CONST_ONE = 8'b1;
parameter CONST_ZERO = 32'b0;
parameter CONST_ONE = 32'b1;
parameter CONST_FOUR = 32'b100;
//
wire [`REGBITS-1:0] ra1, ra2, wa;
wire [`DATA_WIDTH-1:0] pc, nextpc, md, rd1, rd2, wd, a, src1, src2, aluresult,
			aluout, constx, prev_pc;
// shift left constant field by 2
// Modified by Matsutani
//assign constx4 = {instr[DATA_WIDTH-3:0], 2'b00};
// assign constx4 = {instr[16-3:0], 2'b00};
assign constx = {instr[15:0]};
//
// register file address fields
assign ra1 = instr[`REGBITS+20:21];
assign ra2 = instr[`REGBITS+15:16];
mux2 #(`REGBITS) regmux(instr[`REGBITS+15:16], instr[`REGBITS+10:11], regdst, wa);
// independent of bit width, 
// load instruction into four 8-bit registers over four cycles
// Modified by Matsutani
//flopen #(8) ir0(clk, irwrite[0], memdata[7:0], instr[7:0]);
//flopen #(8) ir1(clk, irwrite[1], memdata[7:0], instr[15:8]);
//flopen #(8) ir2(clk, irwrite[2], memdata[7:0], instr[23:16]);
//flopen #(8) ir3(clk, irwrite[3], memdata[7:0], instr[31:24]);
flopen #(32) ir(clk, irwrite[3], memdata[31:0], instr[31:0]);
//
// datapath
flopenr #(`DATA_WIDTH) pcreg(clk, reset_, pcen, nextpc, pc);
flop #(`DATA_WIDTH) mdr(clk, memdata, md);
flop #(`DATA_WIDTH) areg(clk, rd1, a);
flop #(`DATA_WIDTH) wrd(clk, rd2, writedata);
flop #(`DATA_WIDTH) res(clk, aluresult, aluout);
mux2 #(`BUS_ADDR_WIDTH) adrmux(pc[9:0], aluout[9:0], iord, adr);
mux2 #(`DATA_WIDTH) src1mux(pc, a, alusrca, src1);
// Modified by Matsutani
//mux4 #(WIDTH) src2mux(writedata, CONST_ONE, instr[WIDTH-1:0], constx4, 
//			alusrcb, src2);
mux4 #(`DATA_WIDTH) src2mux(writedata, CONST_ONE, {{16{instr[15]}}, instr[15:0]},
			{{16{constx[15]}}, constx[15:0]}, alusrcb, src2);
//
mux4 #(`DATA_WIDTH) pcmux(aluresult, aluout, constx, CONST_ZERO, pcsource, nextpc);
mux2 #(`DATA_WIDTH) wdmux(aluout, md, memtoreg, wd);
regfile #(`DATA_WIDTH,`REGBITS) rf(clk, regwrite, ra1, ra2, wa, wd, rd1, rd2);
alu #(`DATA_WIDTH) alunit(src1, src2, alucont, aluresult);
zerodetect #(`DATA_WIDTH) zd(aluresult, zero);
endmodule

/* alu */
module alu #(parameter WIDTH = 8) (
	input [WIDTH-1:0]	a, b,
	input [2:0]		alucont,
	output reg [WIDTH-1:0]	result
);
wire [WIDTH-1:0]	b2, sum, slt;
assign b2 = alucont[2] ? ~b : b; 
assign sum = a + b2 + alucont[2];
// slt should be 1 if most significant bit of sum is 1
assign slt = sum[WIDTH-1];
always @(*)
	case (alucont[1:0])
		2'b00:	result <= a & b;
		2'b01:	result <= a | b;
		2'b10:	result <= sum;
		2'b11:	result <= slt;
	endcase
endmodule

/* regfile */
module regfile  #(parameter WIDTH = 8, REGBITS = 3) (
	input			clk,
	input			regwrite,
	input [REGBITS-1:0]	ra1, ra2, wa,
	input [WIDTH-1:0]	wd,
	output [WIDTH-1:0]	rd1, rd2
);
reg [WIDTH-1:0] RAM [(1<<REGBITS)-1:0];
// three ported register file
// read two ports combinationally
// write third port on rising edge of clock
// register 0 hardwired to 0
always @(posedge clk)
	if (regwrite) RAM[wa] <= wd;
assign rd1 = ra1 ? RAM[ra1] : 0;
assign rd2 = ra2 ? RAM[ra2] : 0;
endmodule

/* zerodetect */
module zerodetect #(parameter WIDTH = 8) (
	input [WIDTH-1:0]	a,
	output			y
);
assign y = (a == 0);
endmodule

/* flop */
module flop #(parameter WIDTH = 8) (
	input			clk,
	input [WIDTH-1:0]	d,
	output reg [WIDTH-1:0]	q
);
always @(posedge clk)
	q <= d;
endmodule

/* flopen */
module flopen #(parameter WIDTH = 8) (
	input			clk, en,
	input [WIDTH-1:0]	d,
	output reg [WIDTH-1:0]	q
);
always @(posedge clk)
	if (en) q <= d;
endmodule

/* flopenr */
module flopenr #(parameter WIDTH = 8) (
	input			clk, reset_, en,
	input [WIDTH-1:0]	d,
	output reg [WIDTH-1:0]	q
);
always @(posedge clk)
	if (reset_ == `Enable_) q <= 0;
	else if (en) q <= d;
endmodule

/* mux2 */
module mux2 #(parameter WIDTH = 8) (
	input [WIDTH-1:0]	d0, d1,
	input			s,
	output [WIDTH-1:0]	y
);
assign y = s ? d1 : d0;
endmodule

/* mux4 */
module mux4 #(parameter WIDTH = 8) (
	input [WIDTH-1:0]	d0, d1, d2, d3,
	input [1:0]		s,
	output reg [WIDTH-1:0] 	y
);
always @(*)
	case (s)
		2'b00:	y <= d0;
		2'b01:	y <= d1;
		2'b10:	y <= d2;
		2'b11:	y <= d3;
	endcase
endmodule
