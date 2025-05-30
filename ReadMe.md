# 🔧 Portable AVR Assembly Project Setup

This project provides a portable environment for compiling and uploading AVR assembly code using batch scripts. All necessary tools are included within the project folder, making it fully portable and usable from any location — including USB sticks.

---

<br>

## 🚀 Introduction

This setup simplifies AVR assembly development by bundling the assembler (`avra`) and uploader (`avrdude`) tools alongside scripts that automate compiling and flashing your code. You only need to provide the source or hex filename; all configurations and paths are handled internally.

---

<br>

## 📜 License

*This project is released under the MIT License.*

*Included tools (`avra`, `avrdude`) are third-party software and distributed under their respective GPL licenses. Please refer to their documentation for more information.*

---

<br>

## 🛠️ How to Use

<br>

### 🧩 1. Compiling Assembly Code

#### *To compile an assembly file, run:*

     compile.bat filename.asm


- Run the compile script with the assembly filename as parameter:
- This calls `avra` from the project `Tools` folder and uses the local `includes` directory for include files.
- The output hex file will be generated in the same folder.

<br>

### ⚡ 2. Uploading to the AVR Microcontroller

#### *To upload an hex file with default parameters, run:*

      upload.bat filename.hex

#### Optional parameters allow you to specify:

   - Programmer (default: `avrispmkii`)
   - Chip type (default: `attiny85`)
   - Port (default: `usb`)
   - Baud rate (default: `57600`)

#### *To upload an hex file with parameters, run:*

       upload.bat filename.hex [programmer] [chip] [port] [baud]

#### Programmer Examples:
| `usbasp`
| `usbtiny`
| `avrisp`
| `avrispmkii`
| `stk500`
| `jtag2`
| `dragon_isp` |

#### Chips Examples:
| `attiny13`
| `attiny85`
| `atmega8`
| `atmega328p`
| `atxmega128a1` |

<br>

#### *The upload script calls `avrdude` from the project `Tools` folder, ensuring portability.*

---

<br>

## 🎯 Features

- **Portable:** All tools reside inside the project folder; no external installs needed.
- **Configurable:** Upload script supports override of programmer, chip, port, and baudrate.
- **Error Detection:** Both scripts detect and report errors in compilation or upload.
- **Include Support:** `compile.bat` automatically includes files from the local `includes` directory.
- **Environment Isolation:** Uses `setlocal` in batch scripts to avoid environment pollution.

---

<br>

## 💡 Tips

- Make sure your programmer is connected and the correct port is selected before uploading.
- Keep your source `.asm` files and includes organized inside the project folder.
- Use relative paths only to maintain portability.
- You can run the entire setup from a USB drive without changing configurations.

---

<br>

## ✅ Summary

This setup provides a **complete AVR assembly development environment** with zero installation needed. It’s especially useful for learning, teaching, or quick prototyping — even offline.

---

> 💬 *"I created this because I remember how hard it was to get started when everything was poorly explained. Now it's simple, self-contained, and just works."*

<br>

---
---
## 🧪 Happy AVR Hacking – wherever you go!
---
---

<br>
<br>

## 📘 AVR Tool Overview

<br>

## 🔨 AVRA Assembly Compiler:  

    avra -Options

#### Command Example:

    avra main.asm segm1.asm -I includes/ -o output.hex -f ihex

#### Options:

   1. `-l`: Creates a listing file with the extension .lst, containing the assembler code, its addresses, and the generated machine instructions.

   2. `-m`: Creates a file with macro definitions and references.

   3. `-e`: Creates a file with the symbol table.

   4. `-P`: Allows setting the processor used. For example, -P attiny85 for the ATtiny85.

   5. `-d`: Enables debug mode.

   6. `-f`: Allows setting the output format, such as Intel Hex or raw binary.

   7. `-O`: Optimizes the assembler output.

   8. `-D`: Defines macros before starting the assembler.

   9. `-I`: Adds a directory to the search path for include files.

   10. `-N`: Suppresses warnings.

   11. `-o`: Sets the name of the output file.

   12. `-H`: Enables the use of hexadecimal numbers in the source code.

   13. `-x`: Enables support for Atmel XMEGA processors.

   14. `-V`: Displays the assembler version.

   15. `-h`: Displays a help message explaining available options and their usage.


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

<br>

## 📡 AVRDUDE Upload:

        avrdude -Options

#### Options:
    
   1. avrdude: The main command to run Avrdude.

   2. `-c avrispmkii`: Selects the programmer used for communication with the AVR chip. In this case, "avrispmkii," a common AVR programmer.
      arduino

                     avrdude -c ?    \\to list all supported programmer devices.

   4. `-B16`: Sets the bit rate for serial communication with the AVR chip to 16. The B stands for "baud rate."

   5. `-p` attiny85: Selects the specific AVR chip to be accessed. In this case, the ATtiny85.

                     avrdude -p ?   \\to list all supported devices.

   7. `-U flash:w:"%hex":a`: The main command to write firmware (hex file) to the AVR chip. flash:w: means writing to the chip’s flash memory. %hex is the path to the hex file. The :a at the end means the file is transferred in ASCII mode.

   8. `-B %clk`: Dynamically adjusts the serial communication bit rate according to the chip clock frequency. %clk stands for the chip clock.

   9. `-C C:\Programming\avrdude-v7.2-windows-x64\avrdude.conf`: Specifies the configuration file for Avrdude. This file contains various settings and configurations.

   10. `-P usb`: Specifies the communication port for the programmer. Here, it is the USB port.

                      avrdude -P ?    \\lists all available ports, such as USB, COM, or serial interfaces.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
