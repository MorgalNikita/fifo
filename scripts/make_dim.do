quit -sim
vlib work

vlog -sv fifo_junior.sv
vlog -sv fifo_tb.sv


vsim -novopt fifo_tb
add log -r /*

add wave  \
sim:/fifo_tb/clk_i \
sim:/fifo_tb/rst_i \
sim:/fifo_tb/read \
sim:/fifo_tb/write \
sim:/fifo_tb/data_in \
sim:/fifo_tb/data_out \
sim:/fifo_tb/fifo_empty \
sim:/fifo_tb/fifo_full \
sim:/fifo_tb/fifo_ut/mem_fifo \
sim:/fifo_tb/fifo_ut/rd_ptr \
sim:/fifo_tb/fifo_ut/wr_ptr \
sim:/fifo_tb/fifo_ut/fifo_count


run 1500 ns
