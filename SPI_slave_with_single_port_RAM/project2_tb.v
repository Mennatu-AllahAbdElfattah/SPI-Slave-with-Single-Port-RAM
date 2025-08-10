module project_2_tb();

reg clk , rst_n , SS_n , MOSI ;
wire MISO ;

project_2 DUT ( clk , rst_n , SS_n , MOSI , MISO );


initial begin
    clk = 0 ;
    forever begin
        #1 clk = ~clk ;
    end
end

initial begin
    // test reset
    rst_n = 0 ;
    @(negedge clk) ;
    @(negedge clk) ;

    // testing writing adderess
    rst_n = 1 ;
    SS_n = 0 ;  
    @(negedge clk) ;
    MOSI = 0 ;  // going to write state
    @(negedge clk) ;  
    MOSI = 0 ;
    @(negedge clk) ;
    MOSI = 0 ;
    @(negedge clk) ;

    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 0 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 0 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ; //rx_data = 10'b0010111011

    
    // testing writing data
    MOSI = 0 ;  // going to write data state
    @(negedge clk) ;
    MOSI = 0 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;

    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 0 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 0 ;
    @(negedge clk) ;
    MOSI = 0 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ; //rx_data = 10'b0110111001

    // testing reading address
    SS_n = 1 ;  //going back to idle state
    @(negedge clk) ;

    SS_n = 0 ; 
    @(negedge clk) ; 
    MOSI = 1 ;  // going to read address state
    @(negedge clk) ;  
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 0 ;
    @(negedge clk) ;

    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 0 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 0 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ; //rx_data = 10'b1010111011

    // testing reading data
    SS_n = 1 ;  // going back to idle state
    @(negedge clk) ;

    SS_n = 0 ; 
    @(negedge clk) ;
    MOSI = 1 ;  // going to read data state
    @(negedge clk) ; 
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 0 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ;
    MOSI = 0 ;
    @(negedge clk) ;
    MOSI = 1 ;
    @(negedge clk) ; //rx_data = 10'b1010111101
    repeat (12) @(negedge clk) ; 
$stop ;

end
endmodule
