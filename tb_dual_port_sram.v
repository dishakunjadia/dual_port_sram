`timescale 1ns/1ps
module tb_dual_port;

	reg clk = 0;
	always #5 clk = ~clk;
		
	reg we_a, we_b;
	reg en_a, en_b;
	reg[1:0] byte_en_a, byte_en_b;
	reg[4:0] addr_a, addr_b;
	reg[15:0] din_a, din_b;
	wire [15:0] dout_a, dout_b;
	
	dual_port_sram uut(
		.clk(clk),
		.we_a(we_a), .we_b(we_b),
		.en_a(en_a), .en_b(en_b),
		.byte_en_a(byte_en_a), .byte_en_b(byte_en_b),
		.addr_a(addr_a), .addr_b(addr_b),
		.din_a(din_a), .din_b(din_b),
		.dout_a(dout_a), .dout_b(dout_b)
);

	initial begin
		$dumpfile("sim/dual_port_sram.vcd");
		$dumpvars(0, tb_dual_port);

		we_a = 0; we_b = 0;
		en_a = 0; en_b = 0;
		addr_a = 0; addr_b = 0;
		din_a = 0; din_b = 0;
		byte_en_a = 2'b00; byte_en_b = 2'b10;
		#10;

		//Write
		
		en_a = 1; we_a =1; addr_a =5'd2; din_a = 16'hDEAD; byte_en_a = 2'b11;
		en_b = 1; we_b =1; addr_b =5'd3; din_b =16'hBEEF; byte_en_b = 2'b10;
		#10;
		

		//READ
		we_a = 0; addr_a = 5'd2;
		we_b = 0; addr_b = 5'd3;
		#10;

		$display ("Read A: %h", dout_a);
		$display ("Read B: %h", dout_b);
	end
endmodule
