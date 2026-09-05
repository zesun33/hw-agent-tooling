module clean_fifo_ctrl (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        push,
    input  wire [7:0]  data_in,
    output reg  [3:0]  wr_ptr,
    output reg  [3:0]  data_out_trunc,
    output reg         full
);

    // Healed 1: Active-low reset 'if (!rst_n)' matching negedge rst_n
    // Healed 2: Non-blocking assignments '<=' inside sequential block
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr <= 4'b0000;
            full   <= 1'b0;
        end else if (push) begin
            wr_ptr <= wr_ptr + 4'b0001;
            full   <= (wr_ptr == 4'b1111);
        end
    end

    // Healed 3: Explicit bit-slicing [3:0] matching destination bitwidth
    always @* begin
        data_out_trunc = data_in[3:0];
    end

endmodule
