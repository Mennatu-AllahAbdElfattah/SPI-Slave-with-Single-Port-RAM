vlib work
vlog RAM.v SPI.v project2.v project2_tb.v
vsim -voptargs=+acc work.project_2_tb 
add wave -position insertpoint  \
sim:/project_2_tb/clk \
sim:/project_2_tb/rst_n \
sim:/project_2_tb/SS_n \
sim:/project_2_tb/MOSI \
sim:/project_2_tb/MISO 

add wave -position insertpoint  \
sim:/project_2_tb/DUT/rx_valid \
sim:/project_2_tb/DUT/rx_data \
sim:/project_2_tb/DUT/tx_data \
sim:/project_2_tb/DUT/tx_valid 

run -all
#quit -sim
