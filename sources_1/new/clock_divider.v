`timescale 1ns / 1ps
module clock_divider(
    input PCLK,      
    input PRESETn,     
    input [7:0] TCR,    
    input [3:0] Clk,     
    output reg clk_in     
); 
    reg [3:0] counter = 0;
    wire [1:0] cks ;
    assign cks = TCR[1:0];
    initial begin
        clk_in = 0;  
    end
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            counter <= Clk;
            clk_in <= PCLK; 
        end else begin
            case (cks)
                2'b00: begin 
                    if (counter + 1 > 15) begin
                        if (Clk == (counter + 1) - 16) begin
                            clk_in <= ~clk_in;
                            counter <= Clk;
                        end
                    end else if (Clk == counter + 1) begin
                        clk_in <= ~clk_in;
                        counter <= Clk;
                    end
                end
                
                2'b01: begin 
                    if (counter + 2 > 15) begin
                        if (Clk == (counter + 2) - 16) begin
                            clk_in <= ~clk_in;
                            counter <= Clk;
                        end
                    end else if (Clk == counter + 2) begin
                        clk_in <= ~clk_in;
                        counter <= Clk;
                    end
                end
                
                2'b10: begin 
                    if (counter + 4 > 15) begin
                        if (Clk == (counter + 4) - 16) begin
                            clk_in <= ~clk_in;
                            counter <= Clk;
                        end
                    end else if (Clk == counter + 4) begin
                        clk_in <= ~clk_in;
                        counter <= Clk;
                    end
                end
                
                2'b11: begin 
                    if (counter + 8 > 15) begin
                        if (Clk == (counter + 8) - 16) begin
                            clk_in <= ~clk_in;
                            counter <= Clk;
                        end
                    end else if (Clk == counter + 8) begin
                        clk_in <= ~clk_in;
                        counter <= Clk;
                    end
                end
                default:   begin counter <= Clk;
                           clk_in <= PCLK; 
                           end
            endcase
        end
    end
endmodule


//reg [3:0] clk_counter=0;
//initial begin
//    clk_in = 0;
//end 
//always @(posedge PCLK or negedge PRESETn) begin
//        if (!PRESETn) begin
//            clk_counter <= 4'b0;
//            clk_in <= 1'b0;
//        end else begin
//            case (cks) 
//                2'b00: if (clk_counter == 4'b0001) begin
//                    clk_counter <= 4'b0;
//                    clk_in <= ~clk_in;
//                end else begin
//                    clk_counter <= clk_counter + 1;
//                end
//                2'b01: if (clk_counter == 4'b0011) begin
//                    clk_counter <= 4'b0;
//                    clk_in <= ~clk_in;
//                end else begin
//                    clk_counter <= clk_counter + 1;
//                end
//                2'b10: if (clk_counter == 4'b0111) begin
//                    clk_counter <= 4'b0;
//                    clk_in <= ~clk_in;
//                end else begin
//                    clk_counter <= clk_counter + 1;
//                end
//                2'b11: if (clk_counter == 4'b1111) begin
//                    clk_counter <= 4'b0;
//                    clk_in <= ~clk_in;
//                end else begin
//                    clk_counter <= clk_counter + 1;
//                end
//            endcase
//        end
//    end
//endmodule
