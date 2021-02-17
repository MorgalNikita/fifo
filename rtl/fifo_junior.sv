module fifo_junior
#(
  parameter WIDTH_ADDR   = 4, // ширина адресной шины
  parameter WIDTH_DATA   = 8, // ширина шины данных 
  parameter ADDR_W       = 16 // количесвто ячеек памяти

)
(
  input  logic                    clk_i,
  input  logic                    rst_i,
  input  logic                    read,
  input  logic                    write,
  input  logic [WIDTH_DATA  -1:0] data_in,
  output logic [WIDTH_DATA  -1:0] data_out,
  
  output logic  fifo_empty,
  output logic  fifo_full 
);



	logic  [WIDTH_DATA-1:0]   mem_fifo [ADDR_W-1:0];   	// fifo buffer 
	logic  [WIDTH_ADDR -1:0]  rd_ptr, wr_ptr;  
	logic  [4:0]              fifo_count;
	
	assign   fifo_empty = (fifo_count == 0);
	assign   fifo_full  = (fifo_count == ADDR_W);

	
// fifo counter to fifo full and empty	
always_ff @(posedge clk_i or posedge rst_i) begin
   if( rst_i )
       fifo_count <= 0;
   else if( (!fifo_full && write) && ( !fifo_empty && read ) )
       fifo_count <= fifo_count;	 
   else if( !fifo_full && write )
       fifo_count <= fifo_count + 1;
   else if( !fifo_empty && read )
       fifo_count <= fifo_count - 1;
   else
      fifo_count <= fifo_count;
end
	
// fifo_mem read from address 
always_ff @( posedge clk_i or posedge rst_i) begin
   if( rst_i )
      data_out <= 0;
   else begin
      if( read && !fifo_empty )
         data_out <= mem_fifo[rd_ptr];
      else
         data_out <= data_out;
   end
end

// fifo_mem write and reset 1

integer i ;

always_ff @(posedge clk_i) begin
	if ( rst_i ) begin
	for(i=0; i<ADDR_W; i = i+1)
		mem_fifo[i] <= 0;
	end else
   if( write && !fifo_full )
      mem_fifo[ wr_ptr ] <= data_in;
   else
      mem_fifo[ wr_ptr ] <= mem_fifo[ wr_ptr ];
end


// fifo поинтер на запись в buffer fifo
always_ff @(posedge clk_i or posedge rst_i) begin
   if( rst_i ) begin
      wr_ptr <= 0;
      rd_ptr <= 0;
   end else begin
      if( !fifo_full && write )    wr_ptr <= wr_ptr + 1;
          else  wr_ptr <= wr_ptr;
      if( !fifo_empty && read )   rd_ptr <= rd_ptr + 1;
      else rd_ptr <= rd_ptr;
   end
end
endmodule
