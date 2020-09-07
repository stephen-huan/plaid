function plaid_arduino --description "adds the Plaid keyboard to Arduino"
  set path "/Applications/Arduino.app/Contents/Java/hardware/arduino/avr"
  set hex "/Users/stephenhuan/Not Programs/keyboards/plaid/plaid.hex"
  set boards "/Users/stephenhuan/Not Programs/keyboards/plaid/boards.txt"

  cd $path                            # go to Arduino app
  cat $boards >> boards.txt           # update boards.txt
  mkdir bootloaders/plaid             # make folder in bootloader
  cp $hex bootloaders/plaid           # add hex file
  mkdir cores/plaid                   # make new core
  mkdir variants/plaid                # make new variant
  touch variants/plaid/pins_arduino.h # add pin information
end

