module dual_port_sram #(
	parameter DATA_WIDTH = 16,
	parameter ADDR_WIDTH = 5
)(
	input  clk, 
	input we_a,
	input we_b,
	input en_a,
	input en_b,
	input [1:0] byte_en_a,
	input [1:0] byte_en_b,
	input [ADDR_WIDTH-1:0] addr_a,
	input [ADDR_WIDTH-1:0] addr_b,
	input [DATA_WIDTH-1:0] din_a,
	input [DATA_WIDTH-1:0] din_b,
	output reg [DATA_WIDTH-1:0] dout_a,
	output reg [DATA_WIDTH-1:0] dout_b
);
	reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];
	
	always @(posedge clk) begin
		if (en_a) begin
			if (we_a) begin
				if (byte_en_a[0]) mem[addr_a][7:0] <= din_a[7:0];
				if (byte_en_a[1]) mem[addr_a][15:8] <= din_a[15:8];
			end else begin
				dout_a <= mem[addr_a];
			end
		end
		
		if (en_b) begin
			if(we_b) begin
				if (byte_en_b[0]) mem[addr_b][7:0] <= din_b[7:0];
				if (byte_en_b[1]) mem[addr_b][15:8] <= din_b[15:8];
			
			end else begin
				dout_b <= mem[addr_b];
			end
		end
	end
endmodule
