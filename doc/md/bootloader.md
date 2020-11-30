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

[[Video guide]](https://www.youtube.com/watch?v=pyH5Hi-ujLw)

### EEPROM

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

