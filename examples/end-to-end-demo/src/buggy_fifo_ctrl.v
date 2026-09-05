module buggy_fifo_ctrl (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        push,
    input  wire [7:0]  data_in,
    output reg  [3:0]  wr_ptr,
    output reg  [3:0]  data_out_trunc,
    output reg         full
);

    // Flaw 1: negedge rst_n in sensitivity list, but checked active-high 'if (rst_n)'
    // Flaw 2: Blocking assignment '=' inside sequential clocked block
    always @(posedge clk or negedge rst_n) begin
        if (rst_n) begin
            wr_ptr = 4'b0000;
            full   = 1'b0;
        end else if (push) begin
            wr_ptr = wr_ptr + 4'b0001;
            full   = (wr_ptr == 4'b1111);
        end
    end

    // Flaw 3: Implicit bitwidth truncation (8-bit data_in assigned to 4-bit data_out_trunc)
    always @* begin
        data_out_trunc = data_in;
    end

endmodule
