
module uart_tx #(
    parameter CLKS_PER_BIT = 868
)(
    input wire clk,
    input wire rst,
    input wire tx_start,
    input wire [7:0] tx_data,
    output reg tx,
    output reg tx_busy
);

    reg [3:0] bit_index;
    reg [15:0] clock_count;
    reg [9:0] tx_shift;

    always @(posedge clk) begin
        if (rst) begin
            tx <= 1'b1;
            tx_busy <= 1'b0;
            bit_index <= 0;
            clock_count <= 0;
            tx_shift <= 10'b1111111111;
        end
        else begin
            if (!tx_busy && tx_start) begin
                tx_shift <= {1'b1, tx_data, 1'b0};
                tx_busy <= 1'b1;
                bit_index <= 0;
                clock_count <= 0;
            end
            else if (tx_busy) begin
                if (clock_count < CLKS_PER_BIT - 1) begin
                    clock_count <= clock_count + 1;
                end
                else begin
                    clock_count <= 0;
                    tx_shift <= {1'b1, tx_shift[9:1]};
                    bit_index <= bit_index + 1;

                    if (bit_index == 9) begin
                        tx_busy <= 1'b0;
                        tx <= 1'b1;
                    end
                end
            end

            if (tx_busy)
                tx <= tx_shift[0];
            else if (!tx_start)
                tx <= 1'b1;
        end
    end

endmodule
