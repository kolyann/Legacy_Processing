from pprint import pprint
import imp
'''import Processing lib gifAmimation "http://extrapixel.github.io/gif-animation/"'''
myimp = imp.load_source('gifExporter',
        ''.join([os.environ['USERPROFILE'],
                 '\\Documents\\Processing\\py_template\\gifexp\\GifExporter.py']))
from gifExporter import gifExport
import os


step = 0;
mX = 300;
mY = 300;
_fRate = 30;

def setup():
    size(mX,mY)
    colorMode(HSB,360)
    frameRate(_fRate)
    background(360)
    global gifExp
    gifExp = gifExport(False,verbose=True)   
    

def draw():
    global step
    background(180,0,360,60)
    rotate(atan2(-mouseX,mouseY))
    strokeWeight(3)
    line(0,0,0,mY*2)
    line(60,0,60,mY*2)
    strokeWeight(1)
    convl = 10
    for i in range(1,convl+1):
        lY = (i*(2*mY/convl) + step) % (2*mY+1)
        line(0,lY,60,lY)
    gifExp.rec()
    step+=1
