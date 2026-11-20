# UART Design and Simulation Using Verilog

## 1. Project Overview

This project implements a UART (Universal Asynchronous Receiver Transmitter) using Verilog HDL.

UART is a serial communication protocol used to transfer data between electronic devices. It sends data one bit at a time.

The project contains a UART Transmitter (TX), UART Receiver (RX), and a Testbench for simulation.

## 2. Project Objectives

- Design a UART transmitter using Verilog.
- Design a UART receiver using Verilog.
- Understand serial data communication.
- Simulate the design using Icarus Verilog.
- Observe digital waveforms using GTKWave.
- Verify successful data transmission and reception.

## 3. Tools and Technologies

- **Verilog HDL:** Hardware description language used to design digital circuits.
- **Icarus Verilog:** Used to compile and simulate Verilog code.
- **GTKWave:** Used to view simulation waveforms.
- **Visual Studio Code:** Used to write and edit Verilog files.
- **Ubuntu (WSL):** Used as the development environment.

## 4. Project Files

| File | Description |
|---|---|
| `uart_tx.v` | UART transmitter module |
| `uart_rx.v` | UART receiver module |
| `uart_tb.v` | Testbench for testing TX and RX |
| `dump.vcd` | Simulation waveform data |

## 5. Working Principle

The project uses loopback testing, where the transmitter output is directly connected to the receiver input.

Working steps:

1. The transmitter receives 8-bit input data.
2. It adds a start bit and a stop bit.
3. It sends the data serially, one bit at a time.
4. The receiver detects the start bit.
5. The receiver collects the 8 data bits.
6. The receiver completes reception and generates the `rx_done` signal.
7. The testbench compares transmitted and received data.

## 6. Simulation

### Compile the Verilog files

```bash
iverilog -o uart_sim uart_tx.v uart_rx.v uart_tb.v
```

### Run the simulation

```bash
vvp uart_sim
```

### Open the waveform

```bash
gtkwave dump.vcd
```

## 7. Simulation Result

Test data: `A5`

Expected result:

```text
Transmitted Data = a5
Received Data    = a5
UART TEST PASSED
```

The simulation successfully verified that the received data matched the transmitted data.

## 8. Applications

- Microcontroller communication
- Embedded systems
- Serial communication interfaces
- GPS modules
- Electronic debugging

## 9. Conclusion

The UART transmitter and receiver were designed using Verilog HDL and tested through simulation.

The loopback test successfully demonstrated serial data transmission and reception. Icarus Verilog was used for simulation, and GTKWave was used to observe the digital signals.

**Project Status: Simulation Passed**