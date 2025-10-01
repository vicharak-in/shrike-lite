import shrike
import machine
import utime

led = machine.Pin(4, machine.Pin.OUT)
shrike.flash("led_blink.bin")
while True:
    led.value(1)
    utime.sleep(1.0)
    led.value(0)
    utime.sleep(1.0)

