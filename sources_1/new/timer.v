`timescale 1ns / 1ps
module timer(
    input [3:0] Clk,
    input PCLK,     
    input PRESETn,    
    input PSEL,      
    input PENABLE,     
    input PWRITE,           
    input [7:0] PADDR,     
    input [7:0] PWDATA,       
    output [7:0] PRDATA, 
    output PREADY,           
    output PSLVERR         
);
    wire [1:0] cks;
    wire clk_in, Load, Up_Down, EN;
    wire s_tmr_unf, s_tmr_ovf;
    wire [7:0] TCNT, TCR, TDR, TSR;
    assign cks = TCR[1:0];
    assign Load = TCR[7];
    assign Up_Down = TCR[5];
    assign EN = TCR[4];
    
    clock_divider clk_divider (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .cks(cks),
        .Clk(Clk),
        .clk_in(clk_in)
    );
    timer_counter tc (
        .PCLK(PCLK),
        .clk_in(clk_in),
        .PRESETn(PRESETn),
        .s_tmr_unf(s_tmr_unf),
        .s_tmr_ovf(s_tmr_ovf),
        .Load(Load),
        .Up_Down(Up_Down),
        .EN(EN),
        .TDR(TDR),
        .TCNT(TCNT)
    );
    apb_control apb_ctr (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PSEL(PSEL),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA),
        .PREADY(PREADY),
        .PSLVERR(PSLVERR),
        .TCR(TCR),
        .TDR(TDR),
        .TSR(TSR)
    );
    timer_status ts (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .Up_Down(Up_Down),
        .TCNT(TCNT),
        .s_tmr_unf(s_tmr_unf),
        .s_tmr_ovf(s_tmr_ovf)
    );
endmodule


