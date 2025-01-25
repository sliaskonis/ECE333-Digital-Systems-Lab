# Digital Systems Lab Assignments

This repository contains the assignments and projects completed during my **Digital Systems Lab** course at University of Thessaly. The coursework focuses on utilizing advanced computing techniques to solve complex, computationally intensive problems efficiently.

## Table of Contents

- [Digital Systems Lab Assignments](#digital-systems-lab-assignments)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Technologies Used](#technologies-used)
  - [Assignments](#assignments)
  - [More information](#more-information)

## Overview

Thid repository contains assignments focused on digital system deisgn and implementations on FPGAs. The assignments cover a range of topics, including:

- **Digital Logic Design**: Implementing fundamental digital logic blocks like decoders, counters, and finite state machines (FSMs).
- **FPGA Development**: Implementing and testing designs on FPGA development boards.
- **Communication Protocols**: Implementing standard communication protocols like UART.
- **Display Technologies**: Developing drivers for display devices like 7-segment displays and VGA monitors.

## Technologies Used

The projects and assignments were built using the following tools and hardware:

- **Verilog** for hardware description
- **FPGA Development Boards** (Nexys A7)
- **Vivado** IDE for FPGA development

## Assignments

1. **Assignment 1: 7-Segment Display Driver**
    - Implemented a 7-segment display driver on an FPGA
    - Build smaller blocks such as the LED decoder, a 4-bit counter, and the LED driver.
    - Connected the blocks together to drive 4 digits to the display.
    - Made the digits displayed on the display move with the push of a button or after a certain amount of time by applying a constant delay.
    - Used modules such as the shift message, the antibounce, and the delay circuits.
    - Verified the implementation and observed the circuit's behavior through waveforms using testbenches.

2. **Assignment 2: Universal Asynchronous Receiver Transmitter (UART)**
    - Implemented a UART on an FPGA.
    - Built the baud rate controller, transmitter, and receiver.
    - Joined the transmitter and receiver to implement the UART.
    - Verified the implementation using testbenches and observed the circuits behaviour through waveforms.

3. **Assignment 3: Video Graphics Array (VGA) Driver**
    - Implemented a VGA driver on an FPGA.
    - Created a horizontal pixel counter that was synchronized with the HSYNC controller and was used for displaying the active pixel from the VRAM to the monitor.
    - Implemented the VSYNC controller that was responsible for the synchronization of the refresh rate of the monitor, alongside with the vertical pixel counter that was also synchronized with the VSYNC controller.
    - Combined all the previous modules together to implement the VGA driver.
    - Verified the implementation using testbenches and observed the waveforms.

## More information
Under each assignment folder there is a detailed report about assignment-specific details such as step-by-step implementation, results etc.