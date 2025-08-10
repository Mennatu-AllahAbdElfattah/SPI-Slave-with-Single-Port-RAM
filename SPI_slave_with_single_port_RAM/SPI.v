module spi_slave ( clk , rst_n , SS_n , MOSI , tx_valid , tx_data , MISO , rx_valid , rx_data );

parameter IDLE = 3'b000 ; 
parameter CHK_CMD = 3'b001 ;
parameter WRITE = 3'b010 ;
parameter READ_ADDRESS = 3'b011 ;
parameter READ_DATA = 3'b100 ;

input clk , rst_n , SS_n , MOSI , tx_valid ;
input [7:0] tx_data ;
output reg MISO , rx_valid ;
output reg  [9:0] rx_data ;

reg [9:0] rx_data_reg;
reg [7:0] tx_data_reg ;
reg [3:0] count_write;
(* fsm_encoding = "gray" *) reg [2:0] cs, ns ;
reg [3:0] count_read;
reg read_address_is_done;



// next state logic
always @(*) begin
    case (cs)
        IDLE :  
            if (SS_n) begin
                ns = IDLE ;
            end
            else begin
                ns = CHK_CMD ;
            end
        CHK_CMD:
            if (SS_n) begin
                ns = IDLE ;
            end
            else begin
                if (MOSI == 0) begin
                    ns = WRITE ;
                end
                else begin
                    if (read_address_is_done) begin
                        ns = READ_DATA ;
                    end 
                    else begin
                        ns = READ_ADDRESS ;
                    end
                end
            end 
        WRITE:       
            if (SS_n) begin
                ns = IDLE ;
            end
            else begin
                ns = WRITE ;
            end
        READ_ADDRESS:       
            if (SS_n) begin
                ns = IDLE ;
            end
            else begin
                ns = READ_ADDRESS ;
            end  
        READ_DATA:       
            if (SS_n) begin
                ns = IDLE ;
            end
            else begin
                ns = READ_DATA ;
            end                    

        default:  ns = IDLE;
    endcase
end

// state memory
always @(posedge clk) begin
    if (!rst_n) begin
        cs <= IDLE;
    end else begin
        cs <= ns;
    end
end

// output logic
always @( posedge clk ) begin
    if (!rst_n) begin
        rx_data_reg <= 0;
        tx_data_reg <= 0;
        count_write <= 0;
        count_read <= 0;
        read_address_is_done <= 0;
        rx_data <= 0;
        rx_valid <= 0;
        MISO <= 0;
    end 
    else begin
        case (cs)
            WRITE: 
                if (count_write < 10 ) begin     
                    rx_data_reg <= {rx_data_reg[8:0], MOSI};
                    count_write <= count_write + 1 ;
                    rx_valid  <= 0 ;
                end 
                else begin
                    rx_data   <= rx_data_reg;
                    rx_valid  <= 1;
                    count_write <= 0;
                end
            READ_ADDRESS: 
                if (count_write < 10 ) begin     
                    rx_data_reg <= {rx_data_reg[8:0], MOSI};
                    count_write <= count_write + 1 ;
                    rx_valid  <= 0 ;
                end 
                else begin
                    rx_data   <= rx_data_reg;
                    rx_valid  <= 1;
                    count_write <= 0;
                    read_address_is_done <= 1 ;
                end
            READ_DATA: begin
    case (count_read)
        0: begin
            if (count_write < 10) begin
                rx_data_reg <= {rx_data_reg[8:0], MOSI};
                count_write <= count_write + 1;
                rx_valid <= 0;
            end else begin
                rx_data <= rx_data_reg;
                rx_valid <= 1;
                count_write <= 0;
                count_read <= 1;
            end
        end

        1: begin
            if (tx_valid) begin
                tx_data_reg <= tx_data;
                count_read <= 2;
            end
        end

        2,3,4,5,6,7,8,9: begin
            MISO <= tx_data_reg[7];
            tx_data_reg <= {tx_data_reg[6:0], 1'b0};
            count_read <= count_read + 1;
        end

        10: begin
            count_read <= 0;
            read_address_is_done <= 0;
        end
        default: begin
            count_read <= 0;
        end
    endcase
end

                
            default: begin
                rx_data_reg <= 0;
                tx_data_reg <= 0;
                count_write <= 0;
                count_read <= 0;
                rx_valid <= 0 ;
            end
        endcase
    end

end

endmodule
