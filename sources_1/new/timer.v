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
    wire [7:0] TCR;
    wire [7:0] TDR;
    wire [7:0] TSR;
    wire clk_in;
    wire [7:0] TCNT;

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

    clock_divider clk_divider (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .TCR(TCR),
        .Clk(Clk),
        .clk_in(clk_in)
    );

    timer_counter tc (
        .PCLK(PCLK),
        .clk_in(clk_in),
        .PRESETn(PRESETn),
        .TCR(TCR),
        .TDR(TDR),
        .TCNT(TCNT),
        .TSR(TSR)
    );

endmodule
