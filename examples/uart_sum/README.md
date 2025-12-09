# Add Two 8-bit Numbers on FPGA and Return Result via UART

This project demonstrates UART-based communication between an RP2040 and an FPGA. Two 8-bit numbers are sent from the RP2040 to the FPGA over UART. The FPGA stores the received values, performs an addition operation, and then transmits the result back to the RP2040 using UART.

## System Overview

The FPGA implements a small finite state machine (FSM) to sequentially receive and process the data.

UART RX → Register A  
UART RX → Register B  
            ↓  
        8-bit Adder (A + B)  
            ↓  
UART TX → Send SUM

## UART Settings

Default baud rate: 115200

The baud rate can be changed by modifying the parameter in the FPGA top module.

## Included Files

FPGA HDL implementation

Python script for the RP2040 to send operands and receive the result via UART