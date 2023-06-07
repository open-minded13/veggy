import RPi.GPIO as gpio
from subprocess import call
import subprocess
import time

gpio.setmode(gpio.BCM)
gpio.setup(18, gpio.IN, pull_up_down = gpio.PUD_UP)

def set_backlight(channel):
    file = open('/home/veggy/Desktop/Milestone_3/veggy/veggy.py','r+')
    subprocess.run(["python3", '/home/veggy/Desktop/Milestone_3/veggy/veggy.py'])
    
gpio.add_event_detect(18, gpio.FALLING, callback=set_backlight, bouncetime=300)

while 1:
    time.sleep(360)