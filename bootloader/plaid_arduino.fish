function plaid_arduino --description "adds the Plaid keyboard to Arduino"
  set path "/Applications/Arduino.app/Contents/Java/hardware/arduino/avr"
  set root "/Users/stephenhuan/Not Programs/keyboards/plaid/bootloader" 
  set hex "$root/plaid.hex"
  set boards "$root/boards.txt"

  cd $path                            # go to Arduino app
  cat $boards >> boards.txt           # update boards.txt
  mkdir bootloaders/plaid             # make folder in bootloader
  cp $hex bootloaders/plaid           # add hex file
  mkdir cores/plaid                   # make new core
  mkdir variants/plaid                # make new variant
  touch variants/plaid/pins_arduino.h # add pin information
end

