
module uart_rx #(
    parameter CLKS_PER_BIT = 868
)(
    input wire clk,
    input wire rst,
    input wire rx,
    output reg [7:0] rx_data,
    output reg rx_done
);

    localparam IDLE  = 2'b00;
    localparam START = 2'b01;
    localparam DATA  = 2'b10;
    localparam STOP  = 2'b11;

    reg [1:0] state;
    reg [15:0] clock_count;
    reg [2:0] bit_index;
    reg [7:0] rx_shift;

    always @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            clock_count <= 0;
            bit_index <= 0;
            rx_shift <= 0;
            rx_data <= 0;
            rx_done <= 0;
        end else begin
            rx_done <= 0;

            case (state)
                IDLE: begin
                    clock_count <= 0;
                    bit_index <= 0;
                    if (rx == 0)
                        state <= START;
                end

                START: begin
                    if (clock_count < (CLKS_PER_BIT/2))
                        clock_count <= clock_count + 1;
                    else begin
                        clock_count <= 0;
                        if (rx == 0)
                            state <= DATA;
                        else
                            state <= IDLE;
                    end
                end

                DATA: begin
                    if (clock_count < CLKS_PER_BIT - 1)
                        clock_count <= clock_count + 1;
                    else begin
                        clock_count <= 0;
                        rx_shift[bit_index] <= rx;

                        if (bit_index < 7)
                            bit_index <= bit_index + 1;
                        else
                            state <= STOP;
                    end
                end

                STOP: begin
                    if (clock_count < CLKS_PER_BIT - 1)
                        clock_count <= clock_count + 1;
                    else begin
                        clock_count <= 0;
                        rx_data <= rx_shift;
                        rx_done <= 1;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

endmodule
