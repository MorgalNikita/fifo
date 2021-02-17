`timescale 1ps / 1ps
module fifo_tb();

//inp
	logic 		clk_i;
	logic 		rst_i;
	logic 		read;
	logic 		write;
	logic [7:0] data_in;
//outp
	logic 		fifo_empty;
	logic 		fifo_full;
	logic [7:0] data_out;
	integer 		i;

	fifo_junior fifo_ut (
		.clk_i(clk_i), 
		.rst_i(rst_i), 
		.write(write), 
		.read(read), 
		.fifo_empty(fifo_empty),
		.fifo_full(fifo_full),
		.data_in(data_in), 
		.data_out(data_out)
	);
always
	begin
	clk_i 	= 1;
	#5;
	clk_i		= 0;
	#5;
	end
	
	 task fifo_proc;  
      begin  
           for (i = 0; i < 50; i = i + 1) begin: WRE  
                #(6*5) 
                write = 1;  
                data_in = data_in + 1;  
                #(6)  
                write = 0;  
           end  
           #(6)  
           for (i = 0; i < 50; i = i + 1) begin: RDE  
                #(6)  
                read = 1;  
                #(6)  
                read = 0;  
           end  
			  #(6)
			    for (i = 0; i < 50; i = i + 1) begin: RDE_AND_WRE
                #(6)  
                read = 	1;
					 write = 1;
					 data_in = data_in + 1;  
                #(6)  
                read =	0; 
					 write = 0; 
           end  
      end  
		endtask
		
initial begin
	data_in = 2;
	rst_i	  = 0;
	#6;
	rst_i   = 1;
	#6;
	rst_i	  = 0;
	fifo_proc;
end


endmodule
