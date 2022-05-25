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

Note that after entering bootloader mode the keyboard will be unresponsive,
so you must run the command without using the keyboard's "enter" key. This
can be done with a different keyboard. QMK now automatically polls for a
new keyboard after running the flash command, so the flash command can be
ran _before_ entering bootloader mode, removing the need to run the command
_after_ the keyboard is unresponsive.

`qmk flash` will automatically compile the firmware. You
can also compile the firmware without flashing, with
```bash
qmk compile -kb <keyboard> -km <keymap>
```

### NKRO

N-key rollover (NKRO) refers to the capacity of a keyboard to register an
arbitrary number of keys pressed down. On a 6-key rollover (6KRO) keyboard,
for example, only 6 keys (excluding modifiers) can be detected at a time.
If more keys are pressed down, usually the first key to pressed down is
replaced by the new key (at least this is how
[QMK over V-USB works](https://github.com/qmk/qmk_firmware/blob/c3ff06c5345bbf781141c88ebbcca2bc575ead42/tmk_core/protocol/vusb/vusb.c#L241-L248),
though the circular ring buffer data structure). Typically this is a pretty
useless feature, since the average person does not need to press down that
many keys. However, if one is trying to learn stenography with the open-source
[Plover](https://www.openstenoproject.org/plover/) software, a NKRO-supported
keyboard is
[almost required](https://github.com/openstenoproject/plover/wiki/Supported-Hardware#whats-nkro).
Typically "gamer" keyboards and high-end mechanical keyboards are the only
ones to support NKRO. The reason why it is a bit niche (and why so many myths
persist about NKRO) is that there _two_ important characteristics for a
keyboard to support NKRO: on the hardware side and on the software side.

On the hardware side, a good article is ["how to make a keyboard - the
matrix"]( http://blog.komar.be/how-to-make-a-keyboard-the-matrix/), which
discusses the details of scanning the key matrix. In summary, microcontollers
have a limited number of pins, which makes hooking each switch to a pin
impractical. Instead, the keys are arranged in a matrix, and pins are
assigned to columns and rows of this matrix. To get the value of a switch at
a particular row and a particular column, the appropriate pin for the row and
pin for the column are grounded to read the state. The problem is that if
multiple switches are pressed down, there can be interference since switches
are connected to each other through the matrix. The solution is to add a diode
to _each_ switch, which prevents this interference. This is why the plaid
[BOM](./BOM.md) requires 48 general purpose diodes, exactly one for each
switch. Keyboard manufactures are cheap however, and can't spare the few cents
per keyboard to add and solder diodes. Instead, there are various heuristics
and tricks, for example, to make sure commonly pressed keys together are
supported at the cost of rarer key combinations being impossible. This leads to
terms like "ghosting" (when a keycode is sent but its switch is not pressed,
leading to a "ghost" key), or "jamming" (when other switches being pressed
down prevents a new key from being registered). Again, these issues are caused
by the _hardware_ limitation of not using a diode per switch in a key matrix,
and no amount of clever software programming can avoid these issues in general.

On the software side, there are also a lot of myths. A good
article to read is ["Myths about USB NKRO and how USB HID
works"](https://www.devever.net/~hl/usbnkro). The gist is that there are
two different modes: a simplified mode meant for BIOS (on bootup), which
will be referred to "boot mode", and a more complex mode taking advantage
of the USB Human Interface Device (HID) specification. In BIOS mode, the
keyboard sends 8 modifiers (as a single byte, each modifier is a bit), as
well as the last 6 keys. These keys are encoded as _keycodes_, so if there
are 256 possible keys, each key is assigned a number, so each key takes
a byte to encode. This is where the common 6KRO limitation comes from.
Instead, if we were trying to support NKRO, it would be more efficient to
encode keys as a bit mask, that is, a bit for each key indicating whether
it was pressed down or not. This requires the use of the more complicated
but more general USB HID interface. Note that clearly USB is able to support
NKRO, so there is no basis for the myth that only PS/2 connectors are
able to support NKRO because of the limitations of the USB protocol.

In summary, for a keyboard to support NKRO:
- On the hardware side, there must be a diode per key switch. This
  is true for most hobbyist mechanical keyboards, including the plaid.
- On the software side, the firmware must support the more
  general USB HID interface instead of just the BIOS boot mode.

We now come to the specific case for the plaid keyboard. The plaid keyboard
does have a diode per switch, so the hardware on that front is fine. However,
it uses the atmega328p microcontroller, which does not have hardware
USB support. Instead, USB is done through the pins through firmware, in
particular, with [V-USB](https://www.obdev.at/products/vusb/index.html).
This means that the number of endpoints is limited as well as the data
transfer is limited to 8 byte packets. On the software side, QMK supports
NKRO for most keyboards. However, because of these complexities with
V-USB, [NKRO is disabled](https://github.com/qmk/qmk_firmware/pull/9054).
Again, this is not because it is impossible, it is disabled simply
because nobody has wrote code to support NKRO over V-USB. Until this
[pull request](https://github.com/qmk/qmk_firmware/pull/12010),
which unfortunately has not been merged. I maintain a [QMK
fork](https://github.com/stephen-huan/qmk_firmware/tree/vusb-nkro) with
the patch applied.

QMK also supports the [stenography](https://docs.qmk.fm/#/feature_stenography)
protocol, that is, it is able to use the TX Bolt or
GeminiPR protocols. However, due to V-USB [endpoint
limitations](https://github.com/qmk/qmk_firmware/issues/13834) it is
[unlikely to be supported](https://github.com/qmk/qmk_firmware/pull/12010#issuecomment-1088451512).
It remains to be seen if someone will write code for virtser over V-USB.

