module project_2 ( clk , rst_n , SS_n , MOSI , MISO );

input clk , rst_n , SS_n , MOSI ;
output MISO ;

wire tx_valid , rx_valid ;
wire [7:0] tx_data ;
wire [9:0] rx_data ;

spi_slave slave ( clk , rst_n , SS_n , MOSI , tx_valid , tx_data , MISO , rx_valid , rx_data );

spr_sync ram ( clk , rst_n , rx_valid , rx_data , tx_valid , tx_data );



endmodule
