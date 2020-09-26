# Plaid Keyboard

The Plaid keyboard is a 40% ortholinear made from through hole parts, and is
designed by [hsgw](https://github.com/hsgw/plaid).

### PCB/Electronic Parts

Check the [BOM](https://github.com/stephen-huan/plaid/blob/master/plaid_bom.md)
for details.
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

### EEPROM

If your keyboard has swapped keys for seemingly no reason,
especially if you're using the default Plaid keymap,
you may have set the EEPROM, the read-only memory storage for the
microprocessor. To reset the EEPROM, enter bootloader mode
and run the following commands:
```bash
dfu-programmer atmega328p erase
dfu-programmer atmega328p flash --eeprom eeprom_reset.hex
```

`eeprom_reset.hex` was taken from the
[QMK toolbox](https://raw.githubusercontent.com/qmk/qmk_toolbox/3d7c9b4c32f1bb7db49e4b0c2a65859fca20bd27/common/atmega32u4_eeprom_reset.hex).

### Acrylic Guard
Upload `guard/guard.dxf` to [Ponoko](https://www.ponoko.com/).
Recommended material is Clear Impact Modified Acrylic, 2.0mm thick.
Guard prototype designed by [Udbhav Muthakana](https://github.com/udbhav1),
polished by [me](https://github.com/stephen-huan).

### Plate
Upload `plate/GRID_planck_hipro.dxf` to [SendCutSend](https://sendcutsend.com/).
Recommended material is 5052 Aluminium, 1.6mm thick.
DXF file taken from [LaserBoost](https://www.laserboost.com/plates-planck),
the Planck Grid Hi-Pro plate. The Planck is a different PCB, but the dimensions
and screw hole placement are the same.

What are the advantages of using a plate?

1. Switches are aligned, so everything is nice and straight.
2. Flex is noticeably reduced (without a plate, pressing down will bend
the PCB. With a plate, the plate absorbs most of the force).
3. Dust and other particulate accumulates on the plate instead of the PCB.

### Putting it Together

There are two main ways to attach the top PCB to the bottom PCB.
One is the way described in the Plaid
[build guide](https://github.com/hsgw/plaid/blob/master/doc/en/complete.md),
which takes advantage of the fact that a M2 nut is 1.6mm high, and so is the
PCB. Thus, 2 PCBs and 3 nuts are exactly 5*1.6mm = 8mm high.
So a 8mm M2 screw inserted from the top of the top PCB, two nuts between it and
the bottom PCB, and then fastened with the final nut will exactly fit.
However, in my experience, the nuts fall out.

A different way to attach the two PCBs together is with a 3mm spacer.
2*1.6mm + 3mm = 6.2mm, so the screws have to be less than 3mm long.
See the photo for how the setup works.
First, insert one 3mm screw from the top of the top PCB, and screw the spacer
onto it. Then, screw another 3mm screw from the bottom of the bottom PCB into
the existing spacer and it will fasten.

![side.png](https://github.com/stephen-huan/plaid/blob/master/pictures/side.png?raw=true "Side profile")

## Pictures

Completed Plaid without acrylic guard or plate, and with old fuse component.
Notice the alignment problems (right space is higher than left space,
"j" key (ま on the Hiragana keycaps) is also higher than its surroundings).
![plaid.png](https://github.com/stephen-huan/plaid/blob/master/pictures/plaid.png?raw=true "Completed Plaid")
Completed Plaid with plate. Notice the better alignment and the new fuse.
![plate_done.png](https://github.com/stephen-huan/plaid/blob/master/pictures/plate_done.png?raw=true "Completed Plaid with plate")
Plate from SendCutSend fits onto the Plaid PCB although it's a Planck plate!
![alignment.png](https://github.com/stephen-huan/plaid/blob/master/pictures/alignment.png?raw=true "Plate")
Soldered switches
![completed.png](https://github.com/stephen-huan/plaid/blob/master/pictures/completed.png?raw=true "Soldered")

