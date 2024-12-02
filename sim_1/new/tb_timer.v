`timescale 1ns / 1ps
module tb_timer;
    reg [3:0] Clk;    
    reg PCLK;            
    reg PRESETn;           
    reg PSEL;               
    reg PENABLE;        
    reg PWRITE;        
    reg [7:0] PADDR;     
    reg [7:0] PWDATA;       
    wire [7:0] PRDATA;      
    wire PREADY;           
    wire PSLVERR;          
    timer uut (
        .Clk(Clk),
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PSEL(PSEL),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA),
        .PREADY(PREADY),
        .PSLVERR(PSLVERR)
    );

    always #10 PCLK = ~PCLK; 
    always @(posedge PCLK) begin
       if (Clk == 4'b1111)
           Clk = 4'b0000;
       else
           Clk = Clk + 1; 
    end

    initial begin
        PCLK = 0;
        Clk = 0;
        PRESETn = 1;   
//        #20 PRESETn = 1;  
        PSEL = 1;       
        PENABLE = 1;    
        PWRITE = 1; 
        uut.apb_ctr.TCR = 8'b00110000;
//        #20; 
        uut.tc.TCNT = 8'hff;
//        #20;    
//        PADDR = 8'h00;   
//        PWDATA = 8'b00010000; 
//        #20;
        #500 PWDATA = 8'b00010000; 
        #10000;
        PWRITE = 0;  
        PADDR = 8'h01; 
        #20;


        $finish;
    end
endmodule
