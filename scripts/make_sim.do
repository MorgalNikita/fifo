quit -sim

cd ..
cd rtl
vlib work
vlog -sv fifo_junior.sv
vlog -sv ../tb/fifo_tb.sv

vsim -novopt fifo_tb


add log -r /*
add wave  \
sim:/fifo_tb/clk_i \
sim:/fifo_tb/rst_i \
sim:/fifo_tb/read_i \
sim:/fifo_tb/write_i \
sim:/fifo_tb/data_in \
sim:/fifo_tb/data_out \
sim:/fifo_tb/fifo_empty_o \
sim:/fifo_tb/fifo_full_o \
sim:/fifo_tb/fifo_ut/mem_fifo \
sim:/fifo_tb/fifo_ut/rd_ptr \
sim:/fifo_tb/fifo_ut/wr_ptr \
sim:/fifo_tb/fifo_ut/fifo_count
run 5 ns
