`timescale 100ps / 10ps
`define clkperiodby2 10

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:06:14 09/30/2013
// Design Name:   dac
// Module Name:   F:/PROJECTS/SYSTEMS/V_CODES/DAC/tb_dac.v
// Project Name:  DAC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: dac
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_dac;

	reg [7:0] dac_in;
	reg clk;
	reg reset;
	reg [7:0] counter;

	wire dac_out;

	dac uut (
		.dac_in(dac_in), 
		.clk(clk), 
		.reset(reset), 
		.dac_out(dac_out)
	);
	defparam uut.RES = 7;
	
	initial
	begin
		$dumpfile("tb_dac");
		$dumpvars;
	//	$display ( "time \tclk \treset \tdac_in \tdac_out ");
		#1981284252
		$finish;
	end

	initial begin
		
		dac_in <= 8'h01;
		clk <= 0;
		reset <= 1;
		counter <= 0;
		#20
		reset <= 1;
		#20
		reset <= 0;
		
	end
	
	always begin
		#`clkperiodby2 clk <= ~clk;
//		#((`clkperiodby2)*2*256) dac_in <= dac_in + 1;
	end
	
/*	always@(posedge clk)
		counter <= counter + 1;
	
	always@(posedge clk)
	begin
		if(counter == 8'hff) 		begin
			dac_in <= dac_in + 1;
			counter <= 8'b0; 			end
			
		else begin
			dac_in <= dac_in;
			counter <= counter + 1;	end
	end
*/		
		
endmodule

