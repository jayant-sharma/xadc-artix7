`timescale 100ps / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:58:48 09/30/2013 
// Design Name: 
// Module Name:    dac 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dac  #( parameter [7:0] RES = 8'h7
				)( input [RES:0] dac_in,
					input clk,
					input reset,
					output reg dac_out
				);
				
			reg [RES+2:0] d_adder;
			reg [RES+2:0] s_adder;
			reg [RES+2:0] s_latch;
			reg [RES+2:0] d_casc;
			reg [RES:0] v_in;
			reg [RES:0] counter;
			
				
			always@(s_latch)
				d_casc <= { s_latch[RES+2], s_latch[RES+2] } << (RES+1);
				
			always@(v_in or d_casc)
				d_adder <= v_in + d_casc;
				
			always@(d_adder or s_latch)
				s_adder <= d_adder + s_latch;
									
			always@( posedge clk or posedge reset)
			begin
				if(reset)
				begin
					s_latch <= 10'b01_0000_0000;
					dac_out <= 1'b0;
					counter <= 8'b0;
					v_in <= 0;
				end
				
				else
				begin
					v_in <= v_in + 1;
					s_latch <= s_adder;
					dac_out <= s_latch[RES+2];
					
				end				
			end
endmodule
