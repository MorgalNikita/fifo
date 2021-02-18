`timescale 1ps / 1ps
module fifo_tb
#(

	parameter WIDTH_DATA   = 8

);

//input
	logic 						clk_i;
	logic 						rst_i;
	logic 						read_i;
	logic 						write_i;
	logic [WIDTH_DATA -1:0] 			data_in;
//output
	logic 						fifo_empty_o;
	logic 						fifo_full_o;
	logic [WIDTH_DATA-1:0] 				data_out;
	integer 					i;

	fifo_junior fifo_ut (
		.clk_i(clk_i),
		.rst_i(rst_i),
		.write(write_i),
		.read(read_i),
		.fifo_empty(fifo_empty_o),
		.fifo_full(fifo_full_o),
		.data_in(data_in),
		.data_out(data_out)
	);
always
	begin
	clk_i	= 1;
	#5;
	clk_i	= 0;
	#5;
	end
	
	task fifo_proc;
		begin
			for (i = 0; i < 50; i = i + 1) begin: write
				#(6*5)
				write_i = 1;
				data_in = data_in + 1;
				#(6)
				write_i = 0;
			end
				#(6)
			for (i = 0; i < 50; i = i + 1) begin: read
				#(6)
				read_i = 1;
				#(6)
				read_i = 0;
			end
				#(6)
			for (i = 0; i < 50; i = i + 1) begin: read_and_write
				#(6)
				read_i 		=	1;
				write_i 	=	1;
				data_in 	= 	data_in + 1;
				#(6)
				read_i	=	0;
				write_i	=	0;
			end
      end
	endtask
		
initial begin
	data_in			= $urandom(2**WIDTH_DATA);
	rst_i			= 0;
	#6;
	rst_i			= 1;
	#6;
	rst_i			= 0;
	fifo_proc;
	$display("Time = %t",$realtime);
end

endmodule
