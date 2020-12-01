# Bootloader (with ArduinoISP)

Helpful links:
- [ArduinoISP](https://www.arduino.cc/en/tutorial/arduinoISP)
- [USBasploader](https://github.com/hsgw/USBaspLoader/blob/plaid/Makefile.inc)
(to get fuse data)
- [USBasploader](https://github.com/hsgw/USBaspLoader/commit/f7dad45af2a087508cf0997fa31f198fc984535f#diff-50b43beb78bd903d7be28c4bc2f0f4db)
(the actual bootloader data, save as `plaid.hex`)
- [QMK documentation](https://docs.qmk.fm/#/) 
- [Plaid keyboard instructions](https://github.com/hsgw/plaid/blob/master/doc/en/bootloader.md)

## Steps

[[Video guide]](https://www.youtube.com/watch?v=pyH5Hi-ujLw)

### Setting up the Arduino IDE

1. Add the text from `bootloader/boards.txt` to the file at 
`/Applications/Arduino.app/Contents/Java/hardware/arduino/avr/boards.txt`.
I'm going to refer to this path as just `avr` from now on.
Note that these changes revert whenever the Arduino IDE is updated.

2. Make a new folder called plaid in `avr/bootloaders`
and put the `bootloader/plaid.hex` file in that folder.

This is optional, but to remove the Arduino firmware
make an empty folder called plaid in `avr/cores`.
Also, make a folder called plaid in `avr/variants`,
and put an empty file called `pins_arduino.h` in it.

Alternatively, run the provided
[fish script](../../bootloader/plaid_arduino.fish)
(be sure to change the paths).

3. Load the ArudinoISP sketch onto the Arduino you're using
(File > Examples > 11.ArduinoISP > ArduinoISP).
Be sure to select the proper board for the Arudino you're using,
**not** the Plaid keyboard defined in steps 1-2.

### Wiring

Look for the 2x3 header pins on the Arduino labeled ICSP2
and the 2x3 header pins on the Plaid keyboard, labeled J2 and ISP
(left of the atmega328p and below the boot button).
Simply connect each pin of the Arduino to its corresponding pin on the Plaid
keyboard (MISO, +Vcc, SCK, MOSI, Reset, Gnd), with the exception of **reset**.
For some reason, the default ArduinoISP sketch uses pin 10 for reset.
So connect pin 10 on the Arduino to reset on the Plaid keyboard.

Only the Arduino needs to be plugged into your computer.

### Flashing

1. Set the board in the ArduinoIDE to the Plaid keyboard,
which was defined in steps 1-2 of setup.
(Tools > Board > Arduino AVR Boards > Plaid Keyboard)
2. Set the programmer to "Arudino as ISP" or "Arudino as ISP (ATmega32U4)" if
your Arduino uses an atmega32u4. (Tools > Programmer)
3. Press the "Burn Bootloader" button (Tools > Burn Bootloader)

If everything goes well, it should say "Avrdude done. Thank you."
with no error messages. 

Follow the [instructions](../../plaid/doc/en/bootloader.md)
in the original Plaid repository from here.

## EEPROM

If your keyboard has swapped keys for seemingly no reason,
especially if you're using the default Plaid keymap,
you may have written to the EEPROM, read-only memory for the microprocessor.
To reset the EEPROM, enter bootloader mode and run the following commands:
```bash
dfu-programmer atmega328p erase
dfu-programmer atmega328p flash --eeprom bootloader/eeprom_reset.hex
```

`bootloader/eeprom_reset.hex` was taken from the
[QMK toolbox](https://raw.githubusercontent.com/qmk/qmk_toolbox/3d7c9b4c32f1bb7db49e4b0c2a65859fca20bd27/common/atmega32u4_eeprom_reset.hex).

