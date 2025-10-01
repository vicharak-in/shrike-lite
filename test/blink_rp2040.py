import machine
import utime

led = machine.Pin(4, machine.Pin.OUT)

while True:
    led.value(1)
    utime.sleep(1.0)
    led.value(0)
    utime.sleep(1.0)
