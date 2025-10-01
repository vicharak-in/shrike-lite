(fpga_rp2040)=

# FPGA RP2040 Communication Pin-outs

### FPGA CPU Interconnect Pin-outs 

<div align="center">

| FPGA PIN | RP 2040 PIN | S_Fun RP2040     | S_Fun FPGA         |
|----------|-------------|------------------|--------------------|
| 0        | 13          | GPIO UART0-RX /SCL   |GPIO                |
| 1        | 12          | GPIO UART0-TX /SDA   | GPIO               |
| 3        | 2           | GPIO             | SPI_SCLK           |
| 4        | 1           | UART RX / GPIO   | SPI_SS             |
| 5        | 3           | GPIO             | SPI_SI (MOSI)      |
| 6        | 0           | UART TX / GPIO   | SPI_SO (MISO) / CONFIG |

 
</div>
