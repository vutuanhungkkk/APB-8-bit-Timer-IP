`timescale 1ns / 1ps
module timer_status(
    input PCLK,
    input PRESETn,
    input Up_Down,
    input [7:0] TCNT,
    output reg s_tmr_unf,
    output reg s_tmr_ovf
);  
    initial begin
    s_tmr_unf = 0;
    s_tmr_ovf = 0;
    end
    
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            s_tmr_unf <= 0;
            s_tmr_ovf <= 0;
        end else begin
            if ((TCNT == 8'b00000000)&& (Up_Down==1)) begin
                s_tmr_unf <= 1;
                s_tmr_ovf <= 0;
            end else if ((TCNT == 8'b11111111)&&(Up_Down==0)) begin
                s_tmr_unf <= 0;
                s_tmr_ovf <= 1; 
            end else begin
                s_tmr_unf <= 0;
                s_tmr_ovf <= 0; 
            end
        end
    end
endmodule

