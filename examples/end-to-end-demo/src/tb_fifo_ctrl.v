`timescale 1ns/1ps

module tb_fifo_ctrl;
    reg        clk;
    reg        rst_n;
    reg        push;
    reg  [7:0] data_in;
    wire [3:0] wr_ptr;
    wire [3:0] data_out_trunc;
    wire       full;

    clean_fifo_ctrl dut (
        .clk(clk),
        .rst_n(rst_n),
        .push(push),
        .data_in(data_in),
        .wr_ptr(wr_ptr),
        .data_out_trunc(data_out_trunc),
        .full(full)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        push = 0;
        data_in = 8'hA5;
        #15;
        rst_n = 1;
        #10;
        if (wr_ptr !== 4'b0000) $fatal(1, "Reset failed: wr_ptr != 0");
        if (data_out_trunc !== 4'h5) $fatal(1, "Truncation slice failed: data_out_trunc != 0x5");

        push = 1;
        #10;
        if (wr_ptr !== 4'b0001) $fatal(1, "Push 1 failed: wr_ptr != 1");
        #10;
        if (wr_ptr !== 4'b0010) $fatal(1, "Push 2 failed: wr_ptr != 2");

        $display("ALL FIFO TESTS PASSED");
        $finish;
    end
endmodule
