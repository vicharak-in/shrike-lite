# ADD two 8-bit Number on FPGA and send back using UART.

In this example we have demonstrated how to send two 8-bit numbers from RP2040 to FPGA using UART communication and then FPGA add them and send the result back to RP2040 using UART.

In this project, we have implemented a small FSM in FPGA.

UART RX → Register A

UART RX → Register B

    ↓
8-bit Adder (A + B)

    ↓

UART TX → Send SUM

The example works on 115200 baud rate however you can change it form the parameter in the top module.

The python script for the rp2040 is also include here.