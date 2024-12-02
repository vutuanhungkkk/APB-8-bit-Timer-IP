`timescale 1ns / 1ps
module timer_counter(
    input PCLK,
    input clk_in,
    input PRESETn,
    input s_tmr_unf,
    input s_tmr_ovf,
    input Load,
    input Up_Down,
    input EN,  
    input [7:0] TDR,   
    output reg [7:0] TCNT 
);

    reg allow_count;
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            TCNT <= 0;
            allow_count <= 0;
        end else begin
            if (Load) begin
                TCNT <= TDR;
            end else if (s_tmr_unf && allow_count && clk_in) begin
                TCNT <= 8'b11111111;
            end else if (s_tmr_ovf && allow_count && clk_in) begin
                TCNT <= 8'b0;
            end

            if (!clk_in) begin
                allow_count <= 1;
            end

            if (!Load && EN && allow_count && clk_in) begin
                if (Up_Down) begin
                    TCNT <= TCNT - 1;
                end else begin
                    TCNT <= TCNT + 1;
                end
                allow_count <= 0; 
            end
        end
    end
endmodule
