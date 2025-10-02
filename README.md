# SHRIKE_FPGA

![image](./asset/shirke-angle-01.jpg)

We usually work on very complex FPGA-based projects built around Vaaman and its upcoming series. However, Shrike-lite is a passion project at Vicharak—driven by our love for engineering across both embedded microcontrollers and FPGAs.

Our goal is to make FPGAs accessible to everyone by offering robust toolchains, high-quality hardware, and strong ecosystem support. We’re committed to keeping the hardware prices extremely low, and every piece of software for Shrike will be completely open-source.

We invite contributors from all over the world to join us in this mission. Together, let’s make FPGA technology truly accessible to all. 

Shrike-lite is lighter version of world's first fully open source FPGA Dev board [crowdsupply](https://www.crowdsupply.com/vicharak/shrike) releasing on CrowdSupply Renesas Forge FPGA SLG47910 and RP2350. 

We at vicharak have kept in mind need of a learner, maker and a hobbyist while designing this art. This dev board will be your stepping stone in the field of FPGA , reconfigurable and heterogenous computing. 

### Board level Block Diagram

<div align="center">

![shrike](./asset/shrike_lite.svg)

</div>

### Key Features : 

1.  FPGA with 1120 5 Input LUT's
2.  RP2040 - ARM Cortex M0
3.  PMOD Compatible Connector
4.  Bread Board compatible 
5.  IO interface Between FPGA and MCU
6.  QSPI Flash 
7.  2x User LED's
8.  Type C Port for Power and Programming 





<div align="center">

![blink_webp](./asset/shrike_blink.webp)

</div>

## Resources : 

1. [Getting Started Guide ](./Docs/FPGA_Programming.rst)
2. [Comparitive analysis between cpu and FPGA on Shrike](./Docs/RP2040vsFPGA.md)

## Useful Links : 
1. FPGA Datasheet - [Renesas Forge FPGA ](https://www.renesas.com/en/products/programmable-mixed-signal-asic-ip-products/forgefpga-low-density-fpgas/slg47910-1k-lut-forgefpga)

2. EDA Tool - [Go Configure Software Hub](https://www.renesas.com/en/software-tool/go-configure-software-hub)

3. RP2040 Related Resources- [Getting Started ](https://projects.raspberrypi.org/en/projects/getting-started-with-the-pico)

## 📫 Join our communities at :
  
   [<img src="./asset/discord-icon.svg" width="10%"/>](https://discord.com/invite/EhQy97CQ9G)  &nbsp; [<img src="./asset/x_icon.png" width="10%"/>](https://x.com/Vicharak_In)  &nbsp; [<img src="./asset/vicharak_icon.png" width="10%"/>](https://discuss.vicharak.in/)  &nbsp; [<img src="https://img.icons8.com/color/48/000000/linkedin.png" width="10%"/>](https://www.linkedin.com/company/vicharak-in)  &nbsp; [<img src="./asset/reddit_icon.jpeg" width="10%"/>](https://www.reddit.com/r/Vicharak/)  &nbsp;

### Note
 
We are building a ecosystem for learners makers and hobbyist around shrike and the projects that will follow in the future thus we request you contribution in the same. Join our communities across all the platforms,pitch and showcase your ideas with Shrike. 

Thank You 
 


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


## Contribution Guideline  

Your contribution to the shrike project are always welcome . 
To contribute fork the project test your changes and create a PR. Few things in to keep in mind for better contribution 

1. Try to document as much as possible. 
2. Keep your design clean and readable.
3. Do not push unnecessary directories and .env.
4. Make sure your changes can be recreated. 

## Resources 
 #### 1. Learning Resources 

   1. [AISC WORLD Verilog Tutorials ](https://www.asic-world.com/verilog/veritut.html)
   2. [Nandland FPGA Tutorials](https://nandland.com/fpga-101/)
   3. [FPGA for Fun](https://www.fpga4fun.com/)
   4. [Lawrie FPGA Tutorials](https://lawrie.github.io/blackicemxbook/)
   5. [ProjectF](https://projectf.io/)
  
 #### 2. Similar Hardware Projects 
   1. [Ulx3s-Project](https://ulx3s.github.io/)
   2. [TinyFPGA-Project](https://tinyfpga.com/)
   3. [icebreaker-Project](https://github.com/icebreaker-fpga/icebreaker)
   4. [pico-ice](https://pico-ice.tinyvision.ai/)
   
