`timescale 1ns / 1ps
module timer_counter(
    input PCLK,
    input clk_in,
    input PRESETn,
    input [7:0] TCR, 
    input [7:0] TDR,   
    output reg [7:0] TCNT,
    output reg [7:0] TSR
);
    reg clk_in_d;             
    reg s_tmr_ovf_d;          
    reg s_tmr_unf_d;   
    wire s_tmr_unf,s_tmr_ovf,Load,Up_Down,EN;
    assign s_tmr_unf = TSR[1];  
    assign s_tmr_ovf = TSR[0]; 
    assign Load = TCR[7];       
    assign Up_Down = TCR[5];      
    assign EN = TCR[4];        
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            TCNT <= 0;
            clk_in_d <= 0;
            TSR <= 0;
            s_tmr_ovf_d <= 0;
            s_tmr_unf_d <= 0;
        end else begin
            clk_in_d <= clk_in;
            if (Load) begin
                TCNT <= TDR;
            end else if (clk_in && !clk_in_d && !Load) begin
                if (Up_Down) begin
                    if (TCNT == 8'b00000000) begin
                        TCNT <= 8'b11111111;
                        s_tmr_unf_d <= 1; 
                    end else begin
                        TCNT <= TCNT - 1;
                        TSR <= 0;
                    end
                end else begin
                    if (TCNT == 8'b11111111) begin
                        TCNT <= 8'b00000000;
                        s_tmr_ovf_d <= 1;
                    end else begin
                        TCNT <= TCNT + 1;
                        TSR <= 0;
                    end
                end
            end
            if (s_tmr_ovf_d) begin
                TSR <= 8'b00000001; 
                s_tmr_ovf_d <= 0; 
            end else if (s_tmr_unf_d) begin
                TSR <= 8'b00000010;  
                s_tmr_unf_d <= 0; 
            end
            
            if (TSR[0] ||TSR[1] ) begin
                TSR <= 0;
                end
        end
    end
endmodule


