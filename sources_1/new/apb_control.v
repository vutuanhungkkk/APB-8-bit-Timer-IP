`timescale 1ns / 1ps
module apb_control(
    input PCLK,
    input PRESETn,
    input PSEL,
    input PENABLE,
    input PWRITE,
    input [7:0] PADDR,
    input [7:0] PWDATA,
    output reg [7:0] PRDATA,
    output reg PREADY,
    output reg PSLVERR,
    output reg [7:0] TCR,
    output reg [7:0] TDR,
    output reg [7:0] TSR
);
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            TCR <= 8'b0;
            TDR <= 8'b0;
            TSR <= 8'b0;
            PRDATA <= 8'b0;
            PREADY <= 1'b0;
            PSLVERR <= 1'b0;
        end else if (PSEL && PENABLE) begin
            PREADY <= 1'b1;
            if (PWRITE) begin
                case (PADDR)
                    8'h00: TCR <= PWDATA;
                    8'h01: TDR <= PWDATA;
                    8'h02: TSR <= PWDATA;
                    default: PSLVERR <= 1'b1;
                endcase
            end else begin
                case (PADDR)
                    8'h00: PRDATA <= TCR;
                    8'h01: PRDATA <= TSR;
                    default: PSLVERR <= 1'b1;
                endcase
            end
        end else begin
            PREADY <= 1'b0;
        end
    end
endmodule