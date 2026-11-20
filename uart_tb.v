
`timescale 1ns/1ps

module uart_tb;

    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;

    wire tx;
    wire tx_busy;
    wire [7:0] rx_data;
    wire rx_done;

    // Connect transmitter
    uart_tx transmitter (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    // Connect receiver
    uart_rx receiver (
        .clk(clk),
        .rst(rst),
        .rx(tx),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );

    // Generate 50 MHz clock
    always #10 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, uart_tb);

        clk = 0;
        rst = 1;
        tx_start = 0;
        tx_data = 8'hA5;

        #100;
        rst = 0;

        #40;
        tx_start = 1;

        #20;
        tx_start = 0;

        wait(rx_done == 1);

        $display("Transmitted Data = %h", tx_data);
        $display("Received Data    = %h", rx_data);

        if (rx_data == tx_data)
            $display("UART TEST PASSED");
        else
            $display("UART TEST FAILED");

        #100;
        $finish;
    end

endmodule
