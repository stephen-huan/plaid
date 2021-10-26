# Firmware

Follow the getting started instructions of
[QMK](https://docs.qmk.fm/#/newbs_getting_started).

The steps to upload code to the keyboard are:
1. Enter bootloader mode 
2. Flash the firmware 

### Entering Bootloader Mode

1. Push and hold RESET switch
2. Push and hold BOOT switch
3. Release RESET switch
4. Release BOOT switch

### Flashing Firmware

After QMK has been setup, run
```bash
qmk flash -kb plaid -km stephen-huan
```
to write the firmware to the keyboard.

Note that after entering bootloader mode the keyboard will be
unresponsive, so you must run the command without using the
keyboard's "enter" key. This can be done with a different keyboard.

`qmk flash` will automatically compile the firmware. You
can also compile the firmware without flashing, with
```bash
qmk compile -kb <keyboard> -km <keymap>
```

