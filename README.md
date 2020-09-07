# Plaid Keyboard

The Plaid keyboard is a 40% ortholinear made from through hole parts
designed by [hsgw](https://github.com/hsgw/plaid).

### PCB/Electronic Parts

Check the BOM for details.
Upload `plaid_top.zip` and `plaid_bottom.zip` to [JLCPCB](https://jlcpcb.com/).
Zip files (Gerber) were generated according to the instructions
[here](https://support.jlcpcb.com/article/44-how-to-export-kicad-pcb-to-gerber-files).

### ArudinoISP

Helpful links:
- [ArduinoISP](https://www.arduino.cc/en/tutorial/arduinoISP)
- [USBasploader](https://github.com/hsgw/USBaspLoader/blob/plaid/Makefile.inc)
(to get fuse data)
- [USBasploader](https://github.com/hsgw/USBaspLoader/commit/f7dad45af2a087508cf0997fa31f198fc984535f#diff-50b43beb78bd903d7be28c4bc2f0f4db)
(the actual bootloader data, save as `plaid.hex`)
- [QMK documentation](https://docs.qmk.fm/#/) 
- [Plaid keyboard instructions](https://github.com/hsgw/plaid/blob/master/doc/en/bootloader.md)

1. Add the text in this gist's `boards.txt` to the file at 
`/Applications/Arduino.app/Contents/Java/hardware/arduino/avr/boards.txt`.
I'm going to refer to this path as just `/avr` from now on.
Note that these changes revert whenever the Arduino IDE is updated.

2. Make a new folder called plaid in `avr/bootloaders`
and put the `plaid.hex` file in that folder.

This is optional, but to remove the Arduino firmware
make an empty folder called plaid in `avr/cores`.
Also, make a folder called plaid in `avr/variants`,
and put an empty file called `pins_arduino.h` in it.

Alternatively, run the provided fish script (be sure to change the paths).

[Video guide](https://www.youtube.com/watch?v=pyH5Hi-ujLw)

### Acrylic Guard
Order from [ponoko](https://www.ponoko.com/).
Recommended material is Clear Impact Modified Acrylic, 2.0mm thick.


### Plate
Upload `plate/GRID_planck_hipro.dxf` to [sendcutsend](https://sendcutsend.com/).
Recommended material is 5052 Aluminium, 1.6mm thick.

## Pictures

