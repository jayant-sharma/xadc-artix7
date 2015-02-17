`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2014 02:39:41 PM
// Design Name: 
// Module Name: top_ADC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top_ADC
(
	input rst,
    input clkp,
    input clkn,
	input vp,
	input vn
);

wire clk200;
wire dwe, den;
wire busy, drdy, eoc, eos, jtaglocked;
wire [4:0] channel;
wire [6:0] daddr;
wire [15:0] dout, din;

wire rd, wr, valid;
wire [6:0] addr;
wire [15:0] data_out, data_in;

//---------------------------------------------------------
IBUFGDS #(
	 .DIFF_TERM  	("FALSE"),    // Differential Termination
	 .IBUF_LOW_PWR  ("TRUE"),  // Low power="TRUE", Highest performance="FALSE"
	 .IOSTANDARD    ("DEFAULT")  // Specify the input I/O standard
	 ) 
buf200 (
	 .O 			(clk200),  
	 .I 			(clkp),  
	 .IB			(clkn) 
);

//---------------------------------------------------------
fsm_ADC fsm_adcUUT 
(
// User Interface
	.clk			(clk200),
	.rst			(rst),
	.rd				(rd),
	.wr				(wr),
	.addr			(addr),
	.data_in		(data_in),
	.data_out		(data_out),
	.valid			(valid),
// XADC ports
    .jtaglocked     (),
	.busy			(busy),
	.drdy			(drdy),
	.eoc			(eoc),
	.eos			(eos),
	.channel		(channel),
	.dout			(dout),
	.dwe			(dwe),
	.den			(den),
	.daddr			(daddr),
	.din			(din)
);

//---------------------------------------------------------
xadc_wiz_0 ADC_12bit 
(
	.daddr_in		(daddr),
	.dclk_in		(clk200),
	.den_in			(den),
	.di_in			(din),
	.dwe_in			(dwe),
	.reset_in		(0),
	.busy_out		(busy),
	.channel_out	(channel),
	.do_out			(dout),
	.drdy_out		(drdy),
	.eoc_out		(eoc),
	.eos_out		(eos),
	.ot_out			(),
	.alarm_out		(),
	.vp_in			(vp),
	.vn_in			(vn)
);

//------------------- Chipscope --------------------------------------
vio_0 vioUUT (
    .clk            (clk200),        // input wire clk
    .probe_in0      (valid),    // input wire [0 : 0] probe_in0
    .probe_in1      (data_out),    // input wire [15 : 0] probe_in1
    .probe_out0     (wr),       // output wire [1 : 0] probe_out0
    .probe_out1     (rd),       // output wire [1 : 0] probe_out0
    .probe_out2     (addr),          // output wire [6 : 0] probe_out1
    .probe_out3     (data_in)        // output wire [15 : 0] probe_out2
);

endmodule