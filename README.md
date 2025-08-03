# Digital Audio Player with Embedded Audio Intensity Meter

**Academic Integrity Notice**  
- Reuse of any code or implementation details from this project without proper authorization may constitute academic misconduct.  
- If you are a student or educator referencing this project for coursework or research, **you must contact me for permission** before using any part of this work.

## Overview

This project implements a digital audio playback system on an FPGA (DE1-SoC) capable of streaming 8-bit audio samples from on-board QSPI Flash to an external audio DAC at a sampling rate of 44 kHz. The system supports interactive control via a PS/2 keyboard and hardware buttons, and it includes real-time digital signal processing (DSP) features powered by a PicoBlaze soft-core processor.

## Technologies Used

- **SystemVerilog/Verilog** & **PicoBlaze Assembly** - For hardware and embedded DSP implementation
- **Intel Quartus Prime** - For synthesis and FPGA configuration
- **ModelSim** - Simulation and verification
- **DE1-SoC FPGA Board** - Target hardware for deployment
- **PS/2 Keyboard Interface** - For user playback control 
- **Audio DAC** - For analog audio output
- **LEDs** - To visualize audio signal strength

## Features

- **8-bit Audio Streaming**:
  - Reads audio samples from on-board QSPI Flash
  - Streams to external DAC at 44 kHz

- **Flash Memory Interface**:
  - Interfaces with Altera's QSPI Flash Controller via Avalon Memory-Mapped bus
  - Handles timing and synchronization using signals from the flash

- **User Playback Control**:

  - **PS/2 keyboard used for:**

    - **Play (E)**  
      Starts/resumes audio playback

    - **Stop (D)**  
      Pauses audio playback

    - **Forward (F)**  
      Plays the audio forward

    - **Reverse (B)**  
      Rewinds/plays the audio in reverse

    - **Restart (R)** *(bonus feature)*  
      Restarts the audio from the beginning

  - **Hardware buttons:**  
    Control playback speed dynamically in real time

- **Real-Time DSP with PicoBlaze**:
    - Implements a **PicoBlaze soft processor** for audio signal analysis
    - Performs an **interrupt-driven averaging filter over 256 samples** to calculate signal intensity
    - Outputs averaged signal strength to an **LED-based digital volume meter**

## How It Works

1. **Initialization**:
   - Preloaded audio samples reside in QSPI Flash
   - System initializes DAC and prepares playback hardware

2. **Audio Streaming**:
   - A controller reads flash data at 44 kHz and feeds it to the DAC
   - Playback is controlled via PS/2 keyboard

3. **Real-Time Signal Processing**:
   - PicoBlaze processes incoming samples to compute intensity
   - LEDs display real-time signal strength using filtered audio power

4. **User Interaction**:
   - PS/2 keyboard allows playback navigation
   - Hardware buttons adjust playback speed on the fly

## Future Improvements

- Integrate SD card support for large audio libraries or multiple songs
- Display playback status and volume levels on an external screen
- Implement advanced DSP features like FFT or audio equalization

## Setup Instructions

1. Clone this repository:
   ```bash
   git clone https://github.com/ldanh2023/Audio-Player-Project.git
   cd Audio-Player-Project